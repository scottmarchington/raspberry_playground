//
//  Test.swift
//  led-blink
//
//  Created by Scott Marchington on 12/16/17.
//

import Foundation
import PythonAPI
import PerfectPython

class TestPython {
    init() throws {
        print("Load base module")
        let baseModule = try PyObj(import: "Adafruit_MotorHAT")
        
        print("Load Motors Module")
        guard let motorsModule = baseModule.load("Adafruit_MotorHAT_Motors") else {
            print("Failed to load Motors module")
            return
        }
        
        
        print("Load hat class")
        guard let motorHATClass = motorsModule.load("Adafruit_MotorHAT") else {
            print("Failed to load Adafruit_MotorHAT class")
            return
        }
        
        print("Constructing HAT")
        guard let motorHAT = motorHATClass.construct([0x60, 1600]) else {
            print("Failed to init class with filled constructor")
            return
        }
        
        print(motorHAT)
        print("would be cool if this all worked")
    }
}

class MotorHAT2 {
    let motorHAT: PyObj
    
    enum HATErrors: Error {
        case FailedToLoadModule
        case FailedToLoadClass
        case FailedToInitClass
    }
    
    private enum Constants {
        static let containerModuleName: String = "Adafruit_MotorHAT"
        static let motorsModuleName: String = "Adafruit_MotorHAT_Motors"
        static let motorHATClass: String = "Adafruit_MotorHAT"
    }
    
    init(address: Int = 0x60, frequency: Int = 1600) throws {
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
        guard let motorHAT = motorHATClass.construct([0x00, 1600]) else {
            print("Failed to init class with filled constructor")
            throw HATErrors.FailedToInitClass
        }
        
        self.motorHAT = motorHAT
    }
}
