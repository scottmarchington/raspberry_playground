//
//  MotorHAT.swift
//  led-blink
//
//  Created by Scott Marchington on 12/11/17.
//
//  Based off of https://github.com/adafruit/Adafruit-Motor-HAT-Python-Library
//  Commit f9e7c2592c5c720207b4e5040eb28e1628b48f49
//  Thanks, Adafruit!

class MotorHAT {
    enum Command {
        case Forward
        case Backward
        case Brake
        case Release
        
        case Single
        case Double
        case Interleave
        case Microstep
    }
    
    let frequency: Int
    let pwm: PWM
    var motors: [DCMotor]!
    
    init?(_ address: Int = 0x60, frequency: Int = 1600) {
        guard let pwm = PWM(address) else {
            print("Unable to instantiated PWM")
            return nil
        }
        
        self.frequency = frequency
        self.pwm = pwm
        
        // Instantiate Motors as needed
        motors = DCMotor.allMotors(for: self)
        
        // Don't care about steppers for now
        
        pwm.setPWMFrequency(frequency)
    }
    
    func setPin(_ pin: Int, value: Bool) {
        guard 0...15 ~= pin else {
            print("PWM pin must be between 0 and 15 inclusive")
            return
        }
        
        if value {
            pwm.setPWM(pin, on: 4096, off: 0)
        } else {
            pwm.setPWM(pin, on: 0, off: 4096)
        }
    }
}
