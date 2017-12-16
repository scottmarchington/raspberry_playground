import SwiftyGPIO
import PythonAPI
import PerfectPython
import Foundation

Py_Initialize()

_ = TestPython()
print("SUCCESS")

//// Get a dictionary of all the gpio pins
//let gpios: [GPIOName: GPIO] = SwiftyGPIO.GPIOs(for: .RaspberryPi3)
//var routines: [String: Routine] = [:]
//
//// Setup routines
//routines[LEDBlinker.commandLineName] = LEDBlinker(gpios)
//routines[MotorSpinner.commandLineName] = MotorSpinner(gpios)
//
//
//print("Welcome! To quit type exit")
//while let userInput = readLine(strippingNewline: true),
//    userInput != "exit" {
//        if let routine = routines[userInput] {
//            routine.start(on: .P27)
//        } else {
//            print("Unrecognized routine")
//        }
//}

