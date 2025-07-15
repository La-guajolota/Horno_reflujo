import serial
import re

ser = serial.Serial(
        port="/dev/ttyUSB0",
        baudrate=115200,
        bytesize=serial.EIGHTBITS,
        stopbits=serial.STOPBITS_ONE,
        parity=serial.PARITY_NONE,
        rtscts=True
)                                   

REFLOW_PHASES_ES = {
    0: "Precalentamiento",
    1: "Remojo",
    2: "Calentamiento",
    3: "Reflujo",
    4: "Enfriamiento",
    5: "Reposo"
}

#Functions 
def read_port(ser):
    response = ser.readline().decode('utf-8').strip()   
    match = re.match(r"t([0-9.]+)E(\d+)",response)      
    if match:                                           
        temperature = float(match.group(1))             
        state = int(match.group(2))                     
    else:                                               
        temperature = -1.00                             
        state = 5                                       
    return response, temperature, state                 
 
def write_port(ser, msg):
    # We add /r/n character to maintain a standard
    # Then we count the number of characters we are sending 
    msg += "\r\n"
    char_num = len(msg)
    # We let know the MCU's  DMA how many characters to expect
    ser.write(bytes([char_num]))
    # Finnaly we send the full intended message 
    ser.write(msg.encode("utf-8")) 
