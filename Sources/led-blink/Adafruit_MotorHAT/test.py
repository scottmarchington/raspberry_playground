from Adafruit_MotorHAT.Adafruit_MotorHAT_Motors import Adafruit_StepperMotor, Adafruit_DCMotor, Adafruit_MotorHAT

class HATFactory:
    @staticmethod
    def makeHAT():
        return Adafruit_MotorHAT()


