//
//  DCMotor.swift
//  led-blink
//
//  Created by Scott Marchington on 12/11/17.
//
//  Based off of https://github.com/adafruit/Adafruit-Motor-HAT-Python-Library
//  Commit f9e7c2592c5c720207b4e5040eb28e1628b48f49
//  Thanks, Adafruit!

import PerfectPython

class DCMotor {
    var motorID: Int
    var pyObj: PyObj
    
    init?(_ pyObj: PyObj?, motorID: Int) {
        guard let pyObj = pyObj else { return nil }
        
        self.motorID = motorID
        self.pyObj = pyObj
    }
    
    func run(_ command: MotorHAT.Command) {
        _ = pyObj.call("run", args: [command.rawValue])
    }
    
    func setSpeed(_ speed: Int) {
        _ = pyObj.call("setSpeed", args: [speed])
    }
}
