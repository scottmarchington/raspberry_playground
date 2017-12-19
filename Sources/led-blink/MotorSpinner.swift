//
//  MotorSpinner.swift
//  led-blinkPackageDescription
//
//  Created by Scott Marchington on 12/3/17.
//

import Foundation
import SwiftyGPIO

class MotorSpinner: Routine {
    static let commandLineName: String = "motor"
    static let humanReadableName: String = "Motor Spinner"
    
    var hat: MotorHAT?
    
    init?() throws {
        hat = try MotorHAT()
    }
    
    func start() {
        runLoop()
    }
    
    func runLoop() {
        print("Enter a number between 0 and 255 to set the motor's speed, exit to exit")
        while
            hat != nil,
            let userInput = readLine(strippingNewline: true),
            userInput != "exit" {
                guard let newSpeed = Int(userInput) else {
                    print("Invalid input")
                    continue
                }
                updateMotorSpeed(newSpeed)
        }
    }
    
    func updateMotorSpeed(_ newSpeed: Int) {
        guard 0...255 ~= newSpeed else {
            print("New speed must be between 0 and 255, inclusive")
            print("Enter a number between 0 and 255 to set the motor's speed, exit to exit")
            return
        }
        
        guard let hat = hat else {
            print("HAT interface no longer exists, aborting routine")
            self.hat = nil
            return
        }
        
        guard !hat.motors.isEmpty else {
            print("HAT interface has no motors, aborting routine")
            self.hat = nil
            return
        }
        
        // for this test, we're only have motor 3 hooked up, so we'll use that.
        let motor = hat.motors[2]
        
        
        motor.run(.Forward) // set direction
        motor.setSpeed(newSpeed) // set speed
//        sleep(1)
//        motor.run(.Release) // turn on motor
    }
}
