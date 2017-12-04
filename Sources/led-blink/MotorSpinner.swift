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
    }
}
