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
    
    let gpios: [GPIOName: GPIO]
    
    init(_ gpios: [GPIOName: GPIO]) {
        self.gpios = gpios
    }
    
    func start(on gpio: GPIOName) {
        print("This routine has not been implemented yet")
        if let worker = MotorSpinnerWorker() {
            print("worker successfully instantiated")
            // Worker successfully instantiated
        } else {
            print("worker failed to be instantiated")
            // Worker failed to be instantiated
        }
    }
}

class MotorSpinnerWorker {
    enum Constants {
        static let MotorController1Address: Int = 0x60
        static let AllControllersAddress: Int = 0x70 // for sending instructions to ALL controllers in stack
    }
    let interface: I2CInterface
    
    init?() {
        guard let i2cs = SwiftyGPIO.hardwareI2Cs(for: .RaspberryPi3) else {
            print("Couldn't find I2C interfaces")
            return nil
            
        }
        
        print("has \(i2cs.count) interfaces")
        
        guard i2cs.count > 1 else {
            print("Not enough interfaces (has \(i2cs.count))")
            return nil
        }
        
        interface = i2cs[1]
        
        for i in 0..<i2cs.count {
            let interface = i2cs[i]
            
            if interface.isReachable(Constants.MotorController1Address) {
                print("\(Constants.MotorController1Address) on interface \(i) is reachable!")
            } else {
                print("\(Constants.MotorController1Address) on interface \(i)  is not reachable")
            }
        }
    }
    
    func set(to val: Float) {
        
    }
}
