/**
 * @file main.cpp
 * @author José Antonio Gaecía García
 * @author Adrian Silva Palafox
 * @date July 2025
 * @brief ESP8266 Reflow Oven Web GUI Firmware
 * @github https://github.com/La-guajolota/Horno_reflujo
 *
 * This firmware provides a web-based interface for controlling a reflow oven using an ESP8266.
 * It supports real-time monitoring, PID configuration, and thermal profile updates via WebSocket.
 * User commands are sent to the oven controller via UART, following a protocol with message length and CR+LF.
 */

#include <Arduino.h>
#include <ESP8266WiFi.h>
#include <ESPAsyncTCP.h>
#include <ESPAsyncWebServer.h>
#include "configs.hpp"

AsyncWebServer server(80); ///< Web server instance
AsyncWebSocket ws("/ws");  ///< WebSocket handler

// -----------------------------------------------------------------------------
// Global Variables
// -----------------------------------------------------------------------------

String currentTemp = "0.00";             ///< Current temperature as string
String currentStateText = "REFLOW IDLE"; 
String currentAct = "0";             ///< Current actuator (PID out) as string
///< Current state text
String stateNames[6] = {                 ///< State names for display
    "REFLOW PREHEAT",
    "REFLOW SOAK",
    "REFLOW HEATUP",
    "REFLOW REFLOW",
    "REFLOW COOLDOWN",
    "REFLOW IDLE"};
unsigned long lastSend = 0; ///< Last time data was sent to clients

// -----------------------------------------------------------------------------
// Function Documentation
// -----------------------------------------------------------------------------

/**
 * @brief Notify all WebSocket clients with current temperature and state.
 *
 * Sends a JSON string with temperature and state every 250ms.
 */
void notifyClients()
{
  unsigned long now = millis();
  if (now - lastSend >= 250) // Cambiado de 1000ms a 250ms
  {
    String data = "{\"temp\":\"" + currentTemp + "\",\"estado\":\"" + currentStateText + "\",\"act\":\"" + currentAct + "\"}";
    ws.textAll(data);
    lastSend = now;
  }
}

/**
 * @brief Handles incoming UART data from oven controller.
 *
 * Parses messages of the format "t<temp>E<state>", updates global variables,
 * and notifies clients if valid data is received.
 */
void handleSerial()
{
  static String input = "";

  while (Serial.available())
  {
    char c = Serial.read();

    if (c == '\n' || c == '\r')
    {
      if (input.startsWith("t") && input.indexOf('E') > 0)
      {
        int eIndex = input.indexOf('E');
        int pIndex = input.indexOf('P');
        String tempStr;
        if (pIndex > 0 && pIndex < eIndex) {
          tempStr = input.substring(1, pIndex);
        } else {
          tempStr = input.substring(1, eIndex);
        }
        String stateStr = input.substring(eIndex + 1);
        String actStr = (pIndex > 0 && pIndex < eIndex) ? input.substring(pIndex + 1, eIndex) : String("0");


        tempStr.trim();
        stateStr.trim();

        float tempVal = tempStr.toFloat();
        int stateVal = stateStr.toInt();

        if (!isnan(tempVal) && stateVal >= 0 && stateVal <= 5)
        {
          currentTemp = String(tempVal, 2);
          currentStateText = stateNames[stateVal];
          int actVal = actStr.toInt();
          currentAct = String(actVal);
notifyClients();
        }
      }
      input = "";
    }
    else
    {
      input += c;
      if (input.length() > 20)
      {
        input = "";
      }
    }
  }
}

/**
 * @brief Sends a message to the oven controller via UART.
 *
 * The message is appended with CR+LF, then the length is sent as a byte,
 * followed by the message itself.
 * @param msg The message to send (without CR+LF).
 */
void sendUartMessage(const String &msg)
{
  String fullMsg = msg + "\r\n";
  size_t fullLen = fullMsg.length();
  uint8_t charNum = fullLen > 255 ? 255 : fullLen;
  Serial.write(charNum);                                   // Send length byte
  Serial.write((const uint8_t *)fullMsg.c_str(), charNum); // Send message
}

/**
 * @brief Handles WebSocket events (connect, disconnect, data).
 *
 * When user sends commands from the web interface, they are sent to the oven controller via UART.
 * Supported commands: START, STOP, PID parameters, and thermal profile parameters.
 */
void onWebSocketEvent(AsyncWebSocket *server,
                      AsyncWebSocketClient *client,
                      AwsEventType type, void *arg,
                      uint8_t *data, size_t len)
{
  if (type == WS_EVT_CONNECT)
  {
    Serial.println("WebSocket: Cliente conectado");
  }
  else if (type == WS_EVT_DISCONNECT)
  {
    Serial.println("WebSocket: Cliente desconectado");
  }
  else if (type == WS_EVT_DATA)
  {
    AwsFrameInfo *info = (AwsFrameInfo *)arg;
    if (info->final && info->index == 0 && info->len == len)
    {
      String msg = "";
      for (size_t i = 0; i < len; i++)
      {
        msg += (char)data[i];
      }

      // Send command to oven controller via UART
      if (msg == "START")
      {
        sendUartMessage("B1");
      }
      else if (msg == "STOP")
      {
        sendUartMessage("B0");
      }
      else if (msg.startsWith("p") ||
               msg.startsWith("i") ||
               msg.startsWith("d"))
      {
        sendUartMessage(msg);
      }
      else if (msg.length() >= 2 &&
               isAlpha(msg.charAt(0)))
      {
        sendUartMessage(msg);
      }
    }
  }
}

// -----------------------------------------------------------------------------
// HTML Interface (PROGMEM)
// -----------------------------------------------------------------------------

const char index_html[] PROGMEM = R"rawliteral(
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reflow Oven Control</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    :root {
      --primary-color: #00d4ff;
      --secondary-color: #ff6b6b;
      --success-color: #51cf66;
      --warning-color: #ffd43b;
      --error-color: #ff6b6b;
      --bg-primary: #0a0a0a;
      --bg-secondary: #1a1a1a;
      --bg-card: #2a2a2a;
      --text-primary: #ffffff;
      --text-secondary: #b0b0b0;
      --border-color: #3a3a3a;
      --shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, var(--bg-primary), var(--bg-secondary));
      color: var(--text-primary);
      min-height: 100vh;
      padding: 20px;
      overflow-x: hidden;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      animation: fadeIn 0.6s ease-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    h1 {
      text-align: center;
      font-size: 2.5rem;
      margin-bottom: 30px;
      background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      text-shadow: 0 0 30px rgba(0, 212, 255, 0.3);
    }

    .tabs {
      display: flex;
      justify-content: center;
      margin-bottom: 30px;
      background: var(--bg-card);
      border-radius: 15px;
      padding: 8px;
      box-shadow: var(--shadow);
    }

    .tab {
      padding: 12px 24px;
      cursor: pointer;
      background: transparent;
      border: none;
      color: var(--text-secondary);
      border-radius: 10px;
      transition: all 0.3s ease;
      font-size: 1rem;
      font-weight: 500;
      margin: 0 4px;
    }

    .tab:hover {
      background: rgba(0, 212, 255, 0.1);
      color: var(--primary-color);
      transform: translateY(-2px);
    }

    .tab.active {
      background: linear-gradient(45deg, var(--primary-color), #0099cc);
      color: white;
      box-shadow: 0 4px 15px rgba(0, 212, 255, 0.3);
    }

    .tab-content {
      display: none;
      background: var(--bg-card);
      border-radius: 20px;
      padding: 30px;
      box-shadow: var(--shadow);
      border: 1px solid var(--border-color);
    }

    .tab-content.active {
      display: block;
      animation: slideIn 0.4s ease-out;
    }

    @keyframes slideIn {
      from { opacity: 0; transform: translateY(15px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .status-panel {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
      margin-bottom: 30px;
    }

    .status-card {
      background: linear-gradient(135deg, var(--bg-secondary), var(--bg-card));
      padding: 20px;
      border-radius: 15px;
      text-align: center;
      border: 1px solid var(--border-color);
      box-shadow: var(--shadow);
      transition: transform 0.3s ease;
    }

    .status-card:hover {
      transform: translateY(-5px);
    }

    .status-label {
      font-size: 0.9rem;
      color: var(--text-secondary);
      margin-bottom: 10px;
    }

    .status-value {
      font-size: 1.8rem;
      font-weight: bold;
      color: var(--primary-color);
    }

    .chart-container {
      position: relative;
      height: 450px;
      margin: 30px 0;
      background: var(--bg-secondary);
      border-radius: 15px;
      padding: 20px;
      box-shadow: var(--shadow);
    }

    .controls {
      display: flex;
      justify-content: center;
      gap: 20px;
      margin: 30px 0;
    }

    .btn {
      padding: 12px 30px;
      border: none;
      border-radius: 25px;
      font-size: 1rem;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      text-transform: uppercase;
      letter-spacing: 1px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }

    .btn:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
    }

    .btn:active {
      transform: translateY(0);
    }

    .btn-start {
      background: linear-gradient(45deg, var(--success-color), #40c057);
      color: white;
    }

    .btn-stop {
      background: linear-gradient(45deg, var(--error-color), #fa5252);
      color: white;
    }

    .btn:disabled {
      opacity: 0.6;
      cursor: not-allowed;
      transform: none;
    }

    .status-indicator {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      margin: 20px 0;
      font-size: 1.1rem;
      font-weight: 500;
    }

    .indicator-dot {
      width: 12px;
      height: 12px;
      border-radius: 50%;
      animation: pulse 2s infinite;
    }

    .indicator-running {
      background: var(--success-color);
      box-shadow: 0 0 10px var(--success-color);
    }

    .indicator-stopped {
      background: var(--error-color);
      box-shadow: 0 0 10px var(--error-color);
    }

    @keyframes pulse {
      0%, 100% { opacity: 1; }
      50% { opacity: 0.6; }
    }

    .config-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 20px;
    }

    .config-card {
      background: var(--bg-secondary);
      padding: 20px;
      border-radius: 15px;
      border: 1px solid var(--border-color);
      box-shadow: var(--shadow);
    }

    .config-card h3 {
      color: var(--primary-color);
      margin-bottom: 15px;
      font-size: 1.2rem;
    }

    .param-row {
      display: flex;
      align-items: center;
      gap: 15px;
      margin-bottom: 15px;
    }

    .param-label {
      flex: 1;
      font-size: 0.9rem;
      color: var(--text-secondary);
    }

    .param-input {
      padding: 8px 12px;
      border: 1px solid var(--border-color);
      border-radius: 8px;
      background: var(--bg-card);
      color: var(--text-primary);
      width: 100px;
      transition: all 0.3s ease;
    }

    .param-input:focus {
      outline: none;
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(0, 212, 255, 0.2);
    }

    .btn-update {
      background: linear-gradient(45deg, var(--primary-color), #0099cc);
      color: white;
      padding: 8px 16px;
      border: none;
      border-radius: 8px;
      font-size: 0.9rem;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .btn-update:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(0, 212, 255, 0.3);
    }

    @media (max-width: 768px) {
      .status-panel {
        grid-template-columns: 1fr;
      }
      
      .controls {
        flex-direction: column;
        align-items: center;
      }
      
      .tabs {
        flex-direction: column;
        gap: 8px;
      }
      
      .tab {
        width: 100%;
        text-align: center;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>🔥 Reflow Oven Control</h1>

    <div class="tabs">
      <button class="tab active" onclick="switchTab('monitor')">📊 Monitor</button>
      <button class="tab" onclick="switchTab('pid')">⚙️ PID Config</button>
      <button class="tab" onclick="switchTab('perfil')">🌡️ Perfil Térmico</button>
    </div>

    <!-- Monitor Tab -->
    <div id="monitor" class="tab-content active">
      <div class="status-panel">
        <div class="status-card">
          <div class="status-label">Estado del Sistema</div>
          <div class="status-value" id="estado">REFLOW IDLE</div>
        </div>
        <div class="status-card">
          <div class="status-label">Temperatura Actual</div>
          <div class="status-value" id="temp">0.00°C</div>
        </div>
        <div class="status-card">
          <div class="status-label">Actuador (P)</div>
          <div class="status-value" id="act">0</div>
        </div>
      </div>

      <div class="chart-container">
        <canvas id="chart"></canvas>
      </div>

      <div class="controls">
        <button class="btn btn-start" id="toggleBtn">🚀 Iniciar Proceso</button>
      </div>

      <div class="status-indicator" id="indicador">
        <div class="indicator-dot indicator-stopped"></div>
        <span>Sistema Detenido</span>
      </div>
    </div>

    <!-- PID Config Tab -->
    <div id="pid" class="tab-content">
      <div class="config-grid">
        <div class="config-card">
          <h3>⚙️ Configuración PID</h3>
          <div class="param-row">
            <label class="param-label">Proporcional (P):</label>
            <input type="text" class="param-input" id="pid_p" placeholder="1.23">
            <button class="btn-update" onclick="enviarPID('p')">Actualizar</button>
          </div>
          <div class="param-row">
            <label class="param-label">Integral (I):</label>
            <input type="text" class="param-input" id="pid_i" placeholder="0.80">
            <button class="btn-update" onclick="enviarPID('i')">Actualizar</button>
          </div>
          <div class="param-row">
            <label class="param-label">Derivativo (D):</label>
            <input type="text" class="param-input" id="pid_d" placeholder="0.10">
            <button class="btn-update" onclick="enviarPID('d')">Actualizar</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Perfil Térmico Tab -->
    <div id="perfil" class="tab-content">
      <div class="config-grid">
        <div class="config-card">
          <h3>🌡️ Fase de Precalentamiento</h3>
          <div class="param-row">
            <label class="param-label">Velocidad de calentamiento (°C/s):</label>
            <input type="text" class="param-input" id="a" placeholder="1.5">
            <button class="btn-update" onclick="enviarPerfil('a')">Actualizar</button>
          </div>
          <div class="param-row">
            <label class="param-label">Temperatura de remojo (°C):</label>
            <input type="text" class="param-input" id="b" placeholder="150">
            <button class="btn-update" onclick="enviarPerfil('b')">Actualizar</button>
          </div>
          <div class="param-row">
            <label class="param-label">Tiempo de remojo (s):</label>
            <input type="text" class="param-input" id="c" placeholder="90">
            <button class="btn-update" onclick="enviarPerfil('c')">Actualizar</button>
          </div>
        </div>

        <div class="config-card">
          <h3>🔥 Fase de Reflujo</h3>
          <div class="param-row">
            <label class="param-label">Velocidad de calentamiento (°C/s):</label>
            <input type="text" class="param-input" id="D" placeholder="2.0">
            <button class="btn-update" onclick="enviarPerfil('D')">Actualizar</button>
          </div>
          <div class="param-row">
            <label class="param-label">Temperatura de reflujo (°C):</label>
            <input type="text" class="param-input" id="e" placeholder="230">
            <button class="btn-update" onclick="enviarPerfil('e')">Actualizar</button>
          </div>
          <div class="param-row">
            <label class="param-label">Tiempo de reflujo (s):</label>
            <input type="text" class="param-input" id="f" placeholder="45">
            <button class="btn-update" onclick="enviarPerfil('f')">Actualizar</button>
          </div>
        </div>

        <div class="config-card">
          <h3>❄️ Fase de Enfriamiento</h3>
          <div class="param-row">
            <label class="param-label">Velocidad de enfriamiento (°C/s):</label>
            <input type="text" class="param-input" id="g" placeholder="3.0">
            <button class="btn-update" onclick="enviarPerfil('g')">Actualizar</button>
          </div>
          <div class="param-row">
            <label class="param-label">Temperatura final (°C):</label>
            <input type="text" class="param-input" id="h" placeholder="60">
            <button class="btn-update" onclick="enviarPerfil('h')">Actualizar</button>
          </div>
        </div>
      </div>
    </div>

    <div id="wsError" style="display:none;color:#ff6b6b;text-align:center;margin:10px 0;">
      ❌ No se pudo conectar al WebSocket. Revisa la red y reinicia el horno.
    </div>
  </div>

  <script>
    // Variables globales
    const estadoDisplay = document.getElementById("estado");
    const tempDisplay = document.getElementById("temp");
    
    const actDisplay = document.getElementById("act");
const toggleBtn = document.getElementById("toggleBtn");
    const indicador = document.getElementById("indicador");
    let transmitiendo = false; // Solo para el indicador visual
    let estadoAnterior = "REFLOW IDLE"; // <--- NUEVA VARIABLE

    // Configuración del gráfico
    const data = {
      labels: [],
      datasets: [{
        label: 'Temperatura (°C)',
        data: [],
        borderColor: '#00d4ff',
        backgroundColor: 'rgba(0, 212, 255, 0.1)',
        borderWidth: 3,
        fill: true,
        tension: 0.4,
        pointRadius: 0,
        pointHoverRadius: 6
      }]
    };

    const config = {
      type: 'line',
      data: data,
      options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: {
          duration: 0
        },
        plugins: {
          legend: {
            labels: {
              color: '#ffffff',
              font: { size: 14 }
            }
          }
        },
        scales: {
          x: {
            ticks: {
              color: '#b0b0b0',
              maxTicksLimit: 10
            },
            grid: {
              color: '#3a3a3a'
            }
          },
          y: {
            ticks: {
              color: '#b0b0b0'
            },
            grid: {
              color: '#3a3a3a'
            },
            suggestedMin: 0,
            suggestedMax: 250
          }
        }
      }
    };

    const chart = new Chart(document.getElementById('chart'), config);

    // WebSocket
    const ws = new WebSocket(`ws://${location.host}/ws`);

    ws.onmessage = function(event) {
      const msg = JSON.parse(event.data);
      const temp = parseFloat(msg.temp);
      const estado = msg.estado;
      const act = parseInt(msg.act);

      tempDisplay.textContent = temp.toFixed(2) + "°C";
      estadoDisplay.textContent = estado;
      if (!isNaN(act)) { actDisplay.textContent = act; }

      // Detectar transición de COOLDOWN a IDLE
      if (estadoAnterior === "REFLOW COOLDOWN" && estado === "REFLOW IDLE") {
        transmitiendo = false;
        actualizarIndicadores();
      }
      // NUEVO: Detectar estado IDLE directamente
      if (estado === "REFLOW IDLE") {
        transmitiendo = false;
      } else {
        transmitiendo = true;
      }
      actualizarIndicadores();
      estadoAnterior = estado;

      // SIEMPRE agrega el punto, no importa el estado
      const now = new Date().toLocaleTimeString();
      data.labels.push(now);
      data.datasets[0].data.push(temp);

      // Mantén solo los últimos 2400 puntos (~10 minutos si recibes 4/s)
      if (data.labels.length > 2400) {
        data.labels.shift();
        data.datasets[0].data.shift();
      }

      chart.update('none');
    };

    ws.onopen = function() {
      console.log('WebSocket conectado');
      document.getElementById('wsError').style.display = 'none';
    };

    ws.onclose = function() {
      document.getElementById('wsError').style.display = 'block';
      console.log('WebSocket desconectado');
    };

    // Funciones de control
    function actualizarIndicadores() {
      const dot = indicador.querySelector('.indicator-dot');
      const text = indicador.querySelector('span');
      
      if (transmitiendo) {
        dot.className = 'indicator-dot indicator-running';
        text.textContent = 'Sistema Ejecutándose';
        toggleBtn.textContent = '⏹️ Detener Proceso';
        toggleBtn.className = 'btn btn-stop';
      } else {
        dot.className = 'indicator-dot indicator-stopped';
        text.textContent = 'Sistema Detenido';
        toggleBtn.textContent = '🚀 Iniciar Proceso';
        toggleBtn.className = 'btn btn-start';
      }
    }

    toggleBtn.onclick = function() {
      if (transmitiendo) {
        ws.send("STOP");
        transmitiendo = false;
      } else {
        ws.send("START");
        transmitiendo = true;
      }
      actualizarIndicadores();
    };

    // Las funciones de actualización de parámetros NO dependen de transmitiendo:
    function enviarPID(letra) { 
      const input = document.getElementById("pid_" + letra);
      const valor = input.value.trim();
      
      if (!valor || isNaN(valor)) {
        alert("⚠️ Valor inválido para parámetro " + letra.toUpperCase());
        return;
      }
      
      ws.send(letra + valor);
      alert("✅ Parámetro " + letra.toUpperCase() + " actualizado: " + valor);
      // Muestra el valor actualizado en el input (no lo borra)
      input.value = valor;
      // Opcional: resalta el input para indicar actualización
      input.style.backgroundColor = "#003344";
      setTimeout(() => { input.style.backgroundColor = ""; }, 800);
    }

    function enviarPerfil(clave) {
      const input = document.getElementById(clave);
      const valor = input.value.trim();
      
      if (!valor || isNaN(valor)) {
        alert("⚠️ Valor inválido para parámetro " + clave);
        return;
      }
      
      ws.send(clave + valor);
      alert("✅ Parámetro " + clave + " actualizado: " + valor);
      // Muestra el valor actualizado en el input (no lo borra)
      input.value = valor;
      // Opcional: resalta el input para indicar actualización
      input.style.backgroundColor = "#003344";
      setTimeout(() => { input.style.backgroundColor = ""; }, 800);
    }

    function switchTab(tabId) {
      // Remover clases activas
      document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
      document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
      
      // Activar tab seleccionado
      document.querySelector(`[onclick="switchTab('${tabId}')"]`).classList.add('active');
      document.getElementById(tabId).classList.add('active');
    }

    // Inicializar
    actualizarIndicadores();
  </script>
</body>
</html>
)rawliteral";

void setup()
{
  Serial.begin(115200);

  // Static IP configuration
  IPAddress local_IP(192, 168, 1, 150); // Change to desired IP
  IPAddress gateway(192, 168, 1, 1);    // Change to your network gateway
  IPAddress subnet(255, 255, 255, 0);   // Subnet mask
  IPAddress dns(8, 8, 8, 8);            // Optional DNS

  WiFi.config(local_IP, gateway, subnet, dns);

  // Start WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(100); 
    Serial.printf("conectando ...");
  }

  // WebSocket setup
  ws.onEvent(onWebSocketEvent);
  server.addHandler(&ws);

  // Main route
  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request)
            { request->send_P(200, "text/html", index_html); });

  server.begin();
  Serial.printf("OK is on");
}

void loop()
{
  handleSerial();         // Procesa datos UART tan rápido como sea posible
  ws.cleanupClients();
}