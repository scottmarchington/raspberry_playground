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
        let driverModule = try PyObj(path: "./../../Sources/led-blink/Adafruit_MotorHAT", import: "Adafruit_PWM_Servo_Driver")
        
//        let motorModule = try PyObj(path: "./../../Sources/led-blink/Adafruit_MotorHAT", import: "Adafruit_MotorHAT_Motors")
    }
}


