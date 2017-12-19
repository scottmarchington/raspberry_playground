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
        
        
        if let motorHat = motorHatClass.construct([]) {
            print("Init class with all values")
        } else {
            print("Failed to init class with all values")
        }
        
        print("Before getting test module")
        let testModule = try PyObj(path: "../../Sources/led-blink/Adafruit_MotorHAT", import: "test")
        print("After getting test module")
        
        print("Loading HATFactory class")
        guard let ourMotorHATClass = testModule.load("HATFactory") else {
            print("Failed to load MotorHAT")
            return
        }
        
        if let factoryHAT = ourMotorHATClass.call("makeHAT") {
            print("MADE A HAT")
        } else {
            print("Didn't make a HAT")
        }
        
//        if let motorHAT = ourMotorHATClass.construct() {
//            print("Init class!")
//        } else {
//            print("Failed to init class")
//        }
//
//        print("Loading Container")
//        guard let ourContainerClass = testModule.load("MotorContainer") else {
//            print("Failed to load MotorContainer")
//            return
//        }
//
//        if let motorContainer = ourContainerClass.construct() {
//            print("Successfully constructed MotorContainer")
//        } else {
//            print("Failed to construct MotorContainer")
//        }
        
        print("would be cool if this all worked")
    }
}


