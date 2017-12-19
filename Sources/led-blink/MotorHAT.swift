//
//  MotorHAT.swift
//  led-blink
//
//  Created by Scott Marchington on 12/11/17.
//
//  Based off of https://github.com/adafruit/Adafruit-Motor-HAT-Python-Library
//  Commit f9e7c2592c5c720207b4e5040eb28e1628b48f49
//  Thanks, Adafruit!

import PerfectPython

class MotorHAT {
    
    enum HATErrors: Error {
        case FailedToLoadModule
        case FailedToLoadClass
        case FailedToInitClass
        
        case MissingPWM
    }
    
    private enum Constants {
        static let containerModuleName: String = "Adafruit_MotorHAT"
        static let motorsModuleName: String = "Adafruit_MotorHAT_Motors"
        static let motorHATClass: String = "Adafruit_MotorHAT"
    }
    
    enum Command: Int {
        case Forward = 1
        case Backward = 2
        case Brake = 3
        case Release = 4
    }
    
    let frequency: Int
    var motors: [DCMotor]!
    
    var pyObj: PyObj
    
    init(_ address: Int = 0x60, frequency: Int = 1600) throws {
        let baseModule = try PyObj(import: Constants.containerModuleName)
        
        guard let motorsModule = baseModule.load(Constants.motorsModuleName) else {
            print("Failed to load Motors module")
            throw HATErrors.FailedToLoadModule
        }
        
        guard let motorHATClass = motorsModule.load(Constants.motorHATClass) else {
            print("Failed to load Adafruit_MotorHAT class")
            throw HATErrors.FailedToLoadClass
        }
        
        print("Constructing HAT")
        guard let motorHAT = motorHATClass.construct([address, frequency]) else {
            print("Failed to init class with filled constructor")
            throw HATErrors.FailedToInitClass
        }
        
        self.pyObj = motorHAT
        self.frequency = frequency
        
        motors = (1...4).flatMap { DCMotor(getMotor($0), motorID: $0) }
    }
    
    deinit {
        turnOffAllMotors()
    }
    
    func setPin(_ pin: Int, value: Bool) {
        _ = pyObj.call("setPin", args: [pin, value])
    }
    
    func turnOffAllMotors() {
        motors.forEach { $0.run(.Release) }
    }
    
    func getMotor(_ identifier: Int) -> PyObj? {
        return pyObj.call("getMotor", args: [identifier])
    }
}

