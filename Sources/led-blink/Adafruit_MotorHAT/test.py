from Adafruit_MotorHAT.Adafruit_MotorHAT_Motors import Adafruit_StepperMotor, Adafruit_DCMotor, Adafruit_MotorHAT

def makeHAT(address, freq):
    return Adafruit_MotorHAT(address, freq, None, None)
