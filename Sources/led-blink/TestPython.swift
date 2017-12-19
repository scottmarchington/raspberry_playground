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
        guard let motorHatClass = motorsModule.load("Adafruit_MotorHAT") else {
            print("Failed to load Adafruit_MotorHAT class")
            return
        }
        
        if motorHatClass.construct() == nil {
            print("Failed to init class with empty constructor")
        }
        
        print("Before getting test module")
        let testModule = try PyObj(path: "../../Sources/led-blink/Adafruit_MotorHAT", import: "test")
        print("After getting test module")
        
        print("Loading HATFactory class")
        guard let hatFactoryClass = testModule.load("HATFactory") else {
            print("Failed to load HATFactory")
            return
        }
        
        print("Constructing HATFactory")
        guard let hatFactoryObject = hatFactoryClass.construct() else {
            print("Unable to construct HATFactory")
            return
        }
        
        if let factoryHAT = hatFactoryObject.call("makeHAT") {
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


