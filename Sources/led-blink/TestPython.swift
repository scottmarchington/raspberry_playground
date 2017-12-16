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
        let pymodule = try PyObj(path: "../../Sources/Adafruit_MotorHAT/Adafruit_MotorHAT_Motors", import: "Adafruit_MotorHAT")
    }
}


