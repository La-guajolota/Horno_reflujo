import asyncio
import websockets
import json
import openpyxl
from openpyxl.styles import Font, PatternFill
from datetime import datetime
from colorama import Fore, Style, init

# Inicializa colorama para que los colores funcionen en todas las terminales
init(autoreset=True)

# Configuración de ambos dispositivos ESP8266
DEVICES = [
    {"ip": "192.168.1.150", "name": "Horno Principal"},
    {"ip": "192.168.1.140", "name": "Horno Secundario"}
]
ESP_PORT = 80
WEBSOCKET_PATH = "/ws"

# Nombre del archivo Excel único
EXCEL_FILENAME = "regresion_unificado.xlsx"

# Variables globales para el archivo Excel
workbook = None
sheet = None
excel_lock = asyncio.Lock()  # Para evitar conflictos de escritura

def setup_excel():
    global workbook, sheet
    
    try:
        # Intentar cargar el archivo existente
        workbook = openpyxl.load_workbook(EXCEL_FILENAME)
        sheet = workbook.active
        
        # Verificar si las cabeceras ya existen
        if sheet.cell(row=1, column=1).value != "Dispositivo" or \
           sheet.cell(row=1, column=2).value != "Timestamp" or \
           sheet.cell(row=1, column=3).value != "Temperatura (°C)" or \
           sheet.cell(row=1, column=4).value != "Estado":
            
            # Insertar fila de cabeceras si no existen
            sheet.insert_rows(1)
            sheet['A1'] = "Dispositivo"
            sheet['B1'] = "Timestamp"
            sheet['C1'] = "Temperatura (°C)"
            sheet['D1'] = "Estado"
            
            # Aplicar estilos
            header_font = Font(bold=True, color="FFFFFF")
            header_fill = PatternFill(start_color="0070C0", end_color="0070C0", fill_type="solid")
            
            for col in ['A', 'B', 'C', 'D']:
                sheet[f'{col}1'].font = header_font
                sheet[f'{col}1'].fill = header_fill
            
            workbook.save(EXCEL_FILENAME)
            print(f"{Fore.GREEN}✅ Archivo Excel '{EXCEL_FILENAME}' inicializado con nuevas cabeceras.{Style.RESET_ALL}")
        else:
            print(f"{Fore.YELLOW}⚠️ Archivo Excel '{EXCEL_FILENAME}' ya existe. Se añadirán datos a continuación.{Style.RESET_ALL}")
            
    except FileNotFoundError:
        # Crear nuevo archivo si no existe
        workbook = openpyxl.Workbook()
        sheet = workbook.active
        sheet.title = "Datos Hornos Reflujo"
        
        # Cabeceras
        sheet['A1'] = "Dispositivo"
        sheet['B1'] = "Timestamp"
        sheet['C1'] = "Temperatura (°C)"
        sheet['D1'] = "Estado"
        
        # Estilos
        header_font = Font(bold=True, color="FFFFFF")
        header_fill = PatternFill(start_color="0070C0", end_color="0070C0", fill_type="solid")
        
        for col in ['A', 'B', 'C', 'D']:
            sheet[f'{col}1'].font = header_font
            sheet[f'{col}1'].fill = header_fill
            
        workbook.save(EXCEL_FILENAME)
        print(f"{Fore.GREEN}✅ Nuevo archivo Excel '{EXCEL_FILENAME}' creado para ambos dispositivos.{Style.RESET_ALL}")
        
    except Exception as e:
        print(f"{Fore.RED}❌ Error al configurar el archivo Excel: {e}{Style.RESET_ALL}")
        workbook = None
        sheet = None

async def log_to_excel(device_name, timestamp, temp, estado):
    """Registra datos en el Excel compartido con bloqueo para seguridad"""
    global sheet, workbook
    
    if sheet is None or workbook is None:
        return
        
    try:
        async with excel_lock:  # Bloquear para evitar escrituras simultáneas
            row_data = [
                device_name,
                timestamp,
                float(temp),
                estado
            ]
            sheet.append(row_data)
            workbook.save(EXCEL_FILENAME)
    except Exception as e:
        print(f"{Fore.RED}❌ Error al escribir en Excel: {e}{Style.RESET_ALL}")

async def connect_to_esp(device):
    """Establece conexión WebSocket con un dispositivo ESP8266"""
    ip = device['ip']
    name = device['name']
    uri = f"ws://{ip}:{ESP_PORT}{WEBSOCKET_PATH}"
    device_tag = f"{Fore.LIGHTBLACK_EX}[{name}]{Style.RESET_ALL}"
    
    print(f"{device_tag}{Fore.CYAN} 🚀 Intentando conectar a {ip}{Style.RESET_ALL}")

    while True:
        try:
            async with websockets.connect(uri) as websocket:
                print(f"{device_tag}{Fore.GREEN} ✅ Conexión establecida. Esperando datos...{Style.RESET_ALL}")
                
                while True:
                    try:
                        message = await websocket.recv()
                        
                        try:
                            data = json.loads(message)
                            temp = data.get("temp", "N/A")
                            estado = data.get("estado", "N/A")

                            current_time = datetime.now()
                            timestamp_str = current_time.strftime("%Y-%m-%d %H:%M:%S")

                            # Selección de emojis y colores
                            status_emoji = "⏳"
                            temp_color = Fore.WHITE
                            state_color = Fore.WHITE

                            if "IDLE" in estado:
                                status_emoji = "😴"
                                state_color = Fore.BLUE
                            elif "PREHEAT" in estado:
                                status_emoji = "🔥"
                                state_color = Fore.YELLOW
                            elif "SOAK" in estado:
                                status_emoji = "♨️"
                                state_color = Fore.MAGENTA
                            elif "HEATUP" in estado:
                                status_emoji = "⬆️"
                                state_color = Fore.LIGHTRED_EX
                            elif "REFLOW" in estado:
                                status_emoji = "✨"
                                state_color = Fore.RED
                            elif "COOLDOWN" in estado:
                                status_emoji = "❄️"
                                state_color = Fore.CYAN
                            
                            try:
                                temp_val = float(temp)
                                if temp_val < 50:
                                    temp_color = Fore.BLUE
                                elif temp_val < 150:
                                    temp_color = Fore.GREEN
                                elif temp_val < 200:
                                    temp_color = Fore.YELLOW
                                else:
                                    temp_color = Fore.RED
                            except ValueError:
                                pass

                            # Mostrar datos con prefijo de dispositivo
                            print(f"{device_tag} {timestamp_str} | {status_emoji} Estado: {state_color}{estado}{Fore.RESET} | {temp_color}🌡️ {temp}°C{Style.RESET_ALL}")
                            
                            # Registrar en Excel
                            await log_to_excel(name, timestamp_str, temp, estado)

                        except json.JSONDecodeError:
                            print(f"{device_tag}{Fore.YELLOW} ⚠️ Mensaje no JSON: {message}{Style.RESET_ALL}")

                    except websockets.exceptions.ConnectionClosed:
                        print(f"{device_tag}{Fore.RED} ❌ Conexión cerrada. Reconectando en 5s...{Style.RESET_ALL}")
                        break
                    except Exception as e:
                        print(f"{device_tag}{Fore.RED} ❌ Error: {e}. Reconectando en 5s...{Style.RESET_ALL}")
                        break
            
        except (ConnectionRefusedError, asyncio.TimeoutError):
            print(f"{device_tag}{Fore.RED} ❌ Error de conexión. Reintentando en 5s...{Style.RESET_ALL}")
        except Exception as e:
            print(f"{device_tag}{Fore.RED} ❌ Error inesperado: {e}. Reconectando en 5s...{Style.RESET_ALL}")
        
        await asyncio.sleep(5)

async def main():
    """Función principal para manejar múltiples dispositivos"""
    # Configurar Excel unificado
    setup_excel()
    
    # Crear tareas para cada dispositivo
    tasks = [connect_to_esp(device) for device in DEVICES]
    print(f"\n{Fore.YELLOW}💡 Presiona Ctrl+C para salir.{Style.RESET_ALL}")
    
    try:
        await asyncio.gather(*tasks)
    except KeyboardInterrupt:
        print(f"\n{Fore.CYAN}👋 Desconectando dispositivos...{Style.RESET_ALL}")
    finally:
        # Cerrar el archivo Excel
        if workbook:
            try:
                workbook.save(EXCEL_FILENAME)
                workbook.close()
                print(f"{Fore.GREEN}✅ Archivo {EXCEL_FILENAME} guardado y cerrado correctamente{Style.RESET_ALL}")
            except Exception as e:
                print(f"{Fore.RED}❌ Error cerrando Excel: {e}{Style.RESET_ALL}")

if __name__ == "__main__":
    asyncio.run(main())
