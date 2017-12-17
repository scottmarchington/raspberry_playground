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
        guard let motorHatClass = motorsModule.load("Adafruit_MotorHAT") else {
            print("Failed to load Adafruit_MotorHAT class")
            return
        }
        
        if let paradox = motorHatClass.load("Adafruit_MotorHAT_Motors") {
            print("What a time to be alive, we've been going in circles")
            return
        }
        
        if motorHatClass.construct() == nil {
            print("Failed to init class with empty constructor")
        }
        
        
        guard let motorHat = motorHatClass.construct([0x60, 1600, 0, 0]) else {
            print ("Failed to init class with all values")
            return
        }
        
        print("would be cool if this all worked")
    }
}


