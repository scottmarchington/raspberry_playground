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
        
        
        if let motorHat = motorHatClass.construct([0x60, 1600, 0, 0]) {
            print("Init class with all values")
        } else {
            print("Failed to init class with all values")
        }
        
        print("Before getting test module")
        let testModule = try PyObj(path: "../../Sources/led-blink/Adafruit_MotorHAT", import: "test")
        print("After getting test module")
        
        print("Loading MotorHAT subclass")
        guard let ourMotorHATClass = testModule.load("MotorHAT") else {
            print("Failed to load MotorHAT")
            return
        }
        
        if let motorHAT = ourMotorHATClass.construct() {
            print("Init class!")
        } else {
            print("Failed to init class")
        }
        
        print("would be cool if this all worked")
    }
}


