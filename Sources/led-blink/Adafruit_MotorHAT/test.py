from Adafruit_MotorHAT.Adafruit_MotorHAT_Motors import Adafruit_StepperMotor, Adafruit_DCMotor, Adafruit_MotorHAT

class MotorHAT(Adafruit_MotorHAT):
    def __init__(self):
        super(Adafruit_MotorHAT, self).__init__()

class MotorContainer:
    def __init__(self):
        self.motor = Adafruit_MotorHAT()


