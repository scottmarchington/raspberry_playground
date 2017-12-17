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
        let motorsModule = baseModule.load("Adafruit_MotorHAT_Motors")
        
        print("Load fake thing")
        let fakeModule = motorsModule.load("AdaScott_McScottScott")
        
        print("Load hat class")
        let motorHatClass = motorsModule?.load("Adafruit_MotorHAT")
        
        print("would be cool if this all worked")
    }
}


