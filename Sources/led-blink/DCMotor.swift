//
//  DCMotor.swift
//  led-blink
//
//  Created by Scott Marchington on 12/11/17.
//
//  Based off of https://github.com/adafruit/Adafruit-Motor-HAT-Python-Library
//  Commit f9e7c2592c5c720207b4e5040eb28e1628b48f49
//  Thanks, Adafruit!

class DCMotor {
    enum Identifier {
        case Motor1
        case Motor2
        case Motor3
        case Motor4
        
        static var allIdentifiers: [Identifier] {
            return [.Motor1, .Motor2, .Motor3, .Motor4]
        }
    }
    
    static func allMotors(for controller: MotorHAT) -> [DCMotor] {
        return Identifier.allIdentifiers.flatMap { DCMotor($0, controller: controller) }
    }
    
    weak var controller: MotorHAT?
    
    var pwmPin: Int
    var in1Pin: Int
    var in2Pin: Int
    var motorID: Identifier
    
    init?(_ motorID: Identifier, controller: MotorHAT) {
        self.controller = controller
        self.motorID = motorID
        
        switch motorID {
        case .Motor1:
            pwmPin = 8
            in2Pin = 9
            in1Pin = 10
        case .Motor2:
            pwmPin = 13
            in2Pin = 12
            in1Pin = 11
        case .Motor3:
            pwmPin = 2
            in2Pin = 3
            in1Pin = 4
        case .Motor4:
            pwmPin = 7
            in2Pin = 6
            in1Pin = 5
        }
    }
    
    func run(_ command: MotorHAT.Command) {
        guard let controller = controller else {
            print("controller no longer exists")
            return
        }
        
        switch command {
        case .Backward:
            controller.setPin(in1Pin, value: false)
            controller.setPin(in2Pin, value: true)
        case .Forward:
            controller.setPin(in2Pin, value: false)
            controller.setPin(in1Pin, value: true)
        case .Release:
            controller.setPin(in1Pin, value: false)
            controller.setPin(in2Pin, value: false)
        default:
            print("Invalid Command")
        }
    }
    
    func setSpeed(_ speed: Int) {
        guard let controller = controller else {
            print("controller no longer exists")
            return
        }
        
        let clampedSpeed = min(255, max(0, speed))
        controller.pwm.setPWM(pwmPin, on: 0, off: clampedSpeed*16)
    }
}
