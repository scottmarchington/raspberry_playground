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


