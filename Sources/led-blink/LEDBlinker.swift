//
//  LEDBlinker.swift
//  led-blink
//
//  Created by Scott Marchington on 12/3/17.
//

import Foundation
import SwiftyGPIO

class LEDBlinker: Routine {
    let commandLineName: String = "blink"
    let humanReadableName: String = "LED Blinker"
    
    let gpios: [GPIOName: GPIO]
    
    init(_ gpios: [GPIOName: GPIO]) {
        self.gpios = gpios
    }
    
    func start(on pin: GPIOName) {
        // Get the pin that you connected the LED to. Remember to set the right pin number, for me it was 27
        guard let ledGpio = gpios[pin] else {
            fatalError("Could not initialize the gpio")
        }
        
        // Set the pin direction to .OUT and turn it off
        ledGpio.direction = .OUT
        ledGpio.value = 0
        
        // Read user input from keyboard and switch the LED on/off each time the user presses the return key
        print("Press return to switch the LED on/off. To quit type exit")
        while let userInput = readLine(strippingNewline: true), userInput != "exit" {
            print("Switching LED")
            ledGpio.value = ledGpio.value == 0 ? 1 : 0
        }
    }
}
