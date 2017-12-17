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
        
        print("Load fake thing")
        if let fakeModule = motorsModule.load("AdaScott_McScottScott"),
            let fakeObject = fakeModule.construct() {
            print("found fake module?")
            return
        }
        
        
        
        print("Load hat class")
        guard let motorHatClass = motorsModule.load("Adafruit_MotorHAT.Adafruit_MotorHAT_Motors.Adafruit_MotorHAT") else {
            print("Failed to load Adafruit_MotorHAT class")
            return
        }
        
        guard let motorHat = motorHatClass.construct() else {
            print("Failed to init class")
            return
        }
        
        print("would be cool if this all worked")
    }
}


