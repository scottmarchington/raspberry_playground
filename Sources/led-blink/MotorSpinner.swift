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
    let interface: I2CInterface
    
    init?() {
        guard let i2cs = SwiftyGPIO.hardwareI2Cs(for: .RaspberryPi3) else {
            print("Couldn't find I2C interfaces")
            return nil
            
        }
        
        guard i2cs.count > 1 else {
            print("Not enough interfaces (has \(i2cs.count))")
            return nil
        }
        
        interface = i2cs[1]
        
        if interface.isReachable(0x60) {
            print("0x60 is reachable!")
        } else {
            print("0x60 is not reachable")
        }
        
        if interface.isReachable(0x70) {
            print("0x70 is reachable!")
        } else {
            print("0x70 is not reachable")
        }
    }
    
    func set(to val: Float) {
        
    }
}
