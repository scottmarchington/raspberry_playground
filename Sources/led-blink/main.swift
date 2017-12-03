import SwiftyGPIO
import Foundation

// Get a dictionary of all the gpio pins
let gpios: [GPIOName: GPIO] = SwiftyGPIO.GPIOs(for: .RaspberryPi3)
var routines: [String: Routine] = [:]

// Add LEDBlinker to list of routines
let ledBlinker: LEDBlinker = LEDBlinker(gpios)
routines[ledBlinker.commandLineName] = ledBlinker


print("Welcome! To quit type exit")
while let userInput = readLine(strippingNewline: true),
    userInput != "exit" {
        if let routine = routines[userInput] {
            routine.start(on: .P27)
        } else {
            print("Unrecognized routine")
        }
}
