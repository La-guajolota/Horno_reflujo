import asyncio
import websockets
import json
import openpyxl
from openpyxl.styles import Font, PatternFill
from datetime import datetime
import logging
from colorama import Fore, Style, init
from collections import deque
import signal
import sys

# Inicializa colorama
init(autoreset=True)

DEVICE = {"ip": "192.168.1.150", "name": "Horno de Reflujo"}
ESP_PORT = 80
WEBSOCKET_PATH = "/ws"

EXCEL_FILENAME = "regresion_horno.xlsx"

# Buffer para almacenar datos antes de escribir al Excel
DATA_BUFFER = deque()
BUFFER_SIZE = 10  # Escribir cada 10 registros
SAVE_INTERVAL = 30  # Guardar cada 30 segundos como máximo

workbook = None
current_sheet = None
last_save_time = None
shutdown_flag = False

# Configurar logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('horno_client.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

def signal_handler(sig, frame):
    """Maneja la señal SIGINT (Ctrl+C) para cerrar limpiamente"""
    global shutdown_flag
    print(f"\n{Fore.YELLOW}🔄 Cerrando aplicación de forma segura...{Style.RESET_ALL}")
    shutdown_flag = True

def setup_excel():
    global workbook, current_sheet, last_save_time
    
    try:
        workbook = openpyxl.load_workbook(EXCEL_FILENAME)
        print(f"{Fore.YELLOW}⚠️ Archivo Excel '{EXCEL_FILENAME}' ya existe. Creando nueva hoja.{Style.RESET_ALL}")
        logger.info(f"Archivo Excel existente cargado: {EXCEL_FILENAME}")
    except FileNotFoundError:
        workbook = openpyxl.Workbook()
        if 'Sheet' in workbook.sheetnames:
            del workbook['Sheet']
        print(f"{Fore.GREEN}✅ Nuevo archivo Excel '{EXCEL_FILENAME}' creado.{Style.RESET_ALL}")
        logger.info(f"Nuevo archivo Excel creado: {EXCEL_FILENAME}")
    
    session_name = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    current_sheet = workbook.create_sheet(title=session_name)
    
    # Cabeceras
    headers = ["Timestamp", "Temperatura (°C)", "Estado", "Potencia (%)"]
    for idx, header in enumerate(headers, 1):
        current_sheet.cell(row=1, column=idx, value=header)
    
    # Formatear cabeceras
    header_font = Font(bold=True, color="FFFFFF")
    header_fill = PatternFill(start_color="0070C0", end_color="0070C0", fill_type="solid")
    
    for col in range(1, 5):
        current_sheet.cell(row=1, column=col).font = header_font
        current_sheet.cell(row=1, column=col).fill = header_fill
    
    # Ajustar ancho de columnas
    current_sheet.column_dimensions['A'].width = 20
    current_sheet.column_dimensions['B'].width = 15
    current_sheet.column_dimensions['C'].width = 15
    current_sheet.column_dimensions['D'].width = 15
    
    try:
        workbook.save(EXCEL_FILENAME)
        last_save_time = datetime.now()
        print(f"{Fore.GREEN}✅ Nueva hoja '{session_name}' creada para esta sesión.{Style.RESET_ALL}")
        logger.info(f"Nueva hoja creada: {session_name}")
    except Exception as e:
        print(f"{Fore.RED}❌ Error al guardar archivo inicial: {e}{Style.RESET_ALL}")
        logger.error(f"Error guardando archivo inicial: {e}")
        raise
        
    return current_sheet

def validate_data(temp, estado, potencia):
    """Valida y limpia los datos antes de almacenar"""
    # Validar temperatura
    try:
        temp_val = float(temp) if temp not in ["N/A", "", None] else None
        if temp_val is not None and (temp_val < -50 or temp_val > 500):
            temp_val = None  # Temperatura fuera de rango razonable
    except (ValueError, TypeError):
        temp_val = None
    
    # Validar estado
    if not estado or estado == "N/A":
        estado = "UNKNOWN"
    
    # Validar potencia
    try:
        potencia_val = int(potencia) if potencia not in ["N/A", "", None] else None
        if potencia_val is not None and (potencia_val < 0 or potencia_val > 100):
            potencia_val = None  # Potencia fuera de rango 0-100%
    except (ValueError, TypeError):
        potencia_val = None
    
    return temp_val, estado, potencia_val

async def flush_buffer_to_excel():
    """Escribe todos los datos del buffer al Excel"""
    global workbook, current_sheet, DATA_BUFFER, last_save_time
    
    if not DATA_BUFFER or current_sheet is None:
        return
    
    try:
        # Escribir todos los datos del buffer
        while DATA_BUFFER:
            row_data = DATA_BUFFER.popleft()
            current_sheet.append(row_data)
        
        # Guardar archivo
        workbook.save(EXCEL_FILENAME)
        last_save_time = datetime.now()
        logger.info(f"Buffer vaciado y archivo guardado exitosamente")
        
    except Exception as e:
        print(f"{Fore.RED}❌ Error crítico al escribir en Excel: {e}{Style.RESET_ALL}")
        logger.error(f"Error crítico escribiendo Excel: {e}")
        # En caso de error, mantener los datos en el buffer para intentar más tarde
        raise

async def log_to_excel(timestamp, temp, estado, potencia):
    """Registra datos en el buffer para escritura posterior"""
    global DATA_BUFFER, last_save_time
    
    if current_sheet is None:
        logger.warning("No hay hoja activa para escribir datos")
        return
    
    # Validar datos
    temp_val, estado_clean, potencia_val = validate_data(temp, estado, potencia)
    
    # Agregar al buffer
    row_data = [timestamp, temp_val, estado_clean, potencia_val]
    DATA_BUFFER.append(row_data)
    
    # Verificar si necesitamos vaciar el buffer
    current_time = datetime.now()
    time_since_save = (current_time - last_save_time).seconds if last_save_time else SAVE_INTERVAL
    
    should_save = (
        len(DATA_BUFFER) >= BUFFER_SIZE or 
        time_since_save >= SAVE_INTERVAL or 
        shutdown_flag
    )
    
    if should_save:
        try:
            await flush_buffer_to_excel()
        except Exception as e:
            logger.error(f"Error al vaciar buffer: {e}")

async def connect_to_esp():
    global shutdown_flag
    ip = DEVICE['ip']
    name = DEVICE['name']
    uri = f"ws://{ip}:{ESP_PORT}{WEBSOCKET_PATH}"
    device_tag = f"{Fore.LIGHTBLACK_EX}[{name}]{Style.RESET_ALL}"
    
    connection_attempts = 0
    max_attempts = 5
    
    while not shutdown_flag:
        connection_attempts += 1
        print(f"{device_tag}{Fore.CYAN} 🚀 Intento {connection_attempts} - Conectando a {ip}{Style.RESET_ALL}")
        logger.info(f"Intento de conexión {connection_attempts} a {ip}")

        try:
            # Timeout más largo para conexión inicial
            async with websockets.connect(uri, ping_interval=20, ping_timeout=10) as websocket:
                connection_attempts = 0  # Reset counter on successful connection
                print(f"{device_tag}{Fore.GREEN} ✅ Conexión establecida. Esperando datos...{Style.RESET_ALL}")
                logger.info("Conexión WebSocket establecida")
                
                while not shutdown_flag:
                    try:
                        # Timeout para recibir mensajes
                        message = await asyncio.wait_for(websocket.recv(), timeout=30.0)
                        
                        try:
                            data = json.loads(message)
                            temp = data.get("temp", "N/A")
                            estado = data.get("estado", "N/A")
                            potencia = data.get("act", "N/A")

                            current_time = datetime.now()
                            timestamp_str = current_time.strftime("%Y-%m-%d %H:%M:%S")

                            # Selección de emoji y color
                            status_emoji = "⏳"
                            temp_color = Fore.WHITE
                            state_color = Fore.WHITE

                            if "IDLE" in estado:
                                status_emoji = "😴"; state_color = Fore.BLUE
                            elif "PREHEAT" in estado:
                                status_emoji = "🔥"; state_color = Fore.YELLOW
                            elif "SOAK" in estado:
                                status_emoji = "♨️"; state_color = Fore.MAGENTA
                            elif "HEATUP" in estado:
                                status_emoji = "⬆️"; state_color = Fore.LIGHTRED_EX
                            elif "REFLOW" in estado:
                                status_emoji = "✨"; state_color = Fore.RED
                            elif "COOLDOWN" in estado:
                                status_emoji = "❄️"; state_color = Fore.CYAN
                            
                            try:
                                temp_val = float(temp)
                                if temp_val < 50: temp_color = Fore.BLUE
                                elif temp_val < 150: temp_color = Fore.GREEN
                                elif temp_val < 200: temp_color = Fore.YELLOW
                                else: temp_color = Fore.RED
                            except (ValueError, TypeError):
                                temp_color = Fore.WHITE

                            # Mostrar en consola
                            print(f"{device_tag} {timestamp_str} | {status_emoji} Estado: {state_color}{estado}{Fore.RESET} | {temp_color}🌡️ {temp}°C{Style.RESET_ALL} | ⚡ Potencia: {potencia}%")
                            
                            # Guardar en buffer
                            await log_to_excel(timestamp_str, temp, estado, potencia)

                        except json.JSONDecodeError as e:
                            print(f"{device_tag}{Fore.YELLOW} ⚠️ Mensaje no JSON: {message[:100]}...{Style.RESET_ALL}")
                            logger.warning(f"JSON decode error: {e}")

                    except asyncio.TimeoutError:
                        print(f"{device_tag}{Fore.YELLOW} ⚠️ Timeout esperando datos. Verificando conexión...{Style.RESET_ALL}")
                        logger.warning("Timeout esperando datos del WebSocket")
                        # Enviar ping para verificar conexión
                        await websocket.ping()
                        
                    except websockets.exceptions.ConnectionClosed as e:
                        print(f"{device_tag}{Fore.RED} ❌ Conexión cerrada: {e}. Reconectando...{Style.RESET_ALL}")
                        logger.error(f"Conexión WebSocket cerrada: {e}")
                        break
                        
                    except Exception as e:
                        print(f"{device_tag}{Fore.RED} ❌ Error procesando datos: {e}{Style.RESET_ALL}")
                        logger.error(f"Error procesando datos: {e}")
                        # No romper la conexión por errores de procesamiento
            
        except (ConnectionRefusedError, OSError) as e:
            print(f"{device_tag}{Fore.RED} ❌ Error de conexión: {e}{Style.RESET_ALL}")
            logger.error(f"Error de conexión: {e}")
        except asyncio.TimeoutError:
            print(f"{device_tag}{Fore.RED} ❌ Timeout de conexión{Style.RESET_ALL}")
            logger.error("Timeout de conexión")
        except Exception as e:
            print(f"{device_tag}{Fore.RED} ❌ Error inesperado: {e}{Style.RESET_ALL}")
            logger.error(f"Error inesperado: {e}")
        
        if not shutdown_flag:
            if connection_attempts >= max_attempts:
                wait_time = 10
                print(f"{device_tag}{Fore.YELLOW} ⏰ Demasiados intentos fallidos. Esperando {wait_time}s...{Style.RESET_ALL}")
            else:
                wait_time = min(connection_attempts * 2, 10)  # Backoff exponencial
            
            await asyncio.sleep(wait_time)

async def main():
    global workbook, shutdown_flag
    
    # Configurar manejo de señales
    signal.signal(signal.SIGINT, signal_handler)
    
    try:
        setup_excel()
        print(f"\n{Fore.YELLOW}💡 Presiona Ctrl+C para salir de forma segura.{Style.RESET_ALL}")
        print(f"{Fore.CYAN}📊 Los datos se guardan cada {BUFFER_SIZE} registros o cada {SAVE_INTERVAL} segundos.{Style.RESET_ALL}")
        
        await connect_to_esp()
        
    except KeyboardInterrupt:
        print(f"\n{Fore.CYAN}👋 Interrupción detectada, cerrando...{Style.RESET_ALL}")
        shutdown_flag = True
    except Exception as e:
        print(f"{Fore.RED}❌ Error crítico en main: {e}{Style.RESET_ALL}")
        logger.critical(f"Error crítico: {e}")
    finally:
        # Asegurar que todos los datos se guarden
        if DATA_BUFFER:
            print(f"{Fore.YELLOW}💾 Guardando datos pendientes...{Style.RESET_ALL}")
            try:
                await flush_buffer_to_excel()
                print(f"{Fore.GREEN}✅ Datos pendientes guardados{Style.RESET_ALL}")
            except Exception as e:
                print(f"{Fore.RED}❌ Error guardando datos finales: {e}{Style.RESET_ALL}")
        
        if workbook:
            try:
                workbook.save(EXCEL_FILENAME)
                workbook.close()
                print(f"{Fore.GREEN}✅ Archivo {EXCEL_FILENAME} guardado y cerrado correctamente{Style.RESET_ALL}")
                logger.info("Archivo Excel cerrado correctamente")
            except Exception as e:
                print(f"{Fore.RED}❌ Error cerrando Excel: {e}{Style.RESET_ALL}")
                logger.error(f"Error cerrando Excel: {e}")

if __name__ == "__main__":
    asyncio.run(main())
