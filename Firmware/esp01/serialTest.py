from serialUtils import *

def main():
    if ser.is_open:
        ser.close()
        print("Port has been closed because it was open before running this program")
    try:
        ser.open()
        print("Port has been open correctly")
  
        # Update values via uart
        write_port(ser,"p123.456")
        write_port(ser,"B1")
    
        while True:
            raw, temp, st = read_port(ser)
            print(f"Raw RX message: {raw}")
            print(f"Temperature: {temp} | Oven's state: {REFLOW_PHASES_ES.get(st,"Unknow")}")

            # Emulate sending temperature and reflow states
            
            
    except KeyboardInterrupt:
        print("Exiting")
    except serial.SerialException as e:
        print(f"Couldn't open the port: {e}")
    finally:
        if ser.is_open:
            ser.close()
            print("Port has been closed")

if __name__ == "__main__":
    print("Program started!!!")
    main()
