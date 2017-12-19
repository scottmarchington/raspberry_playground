import SwiftyGPIO
import PythonAPI
import PerfectPython
import Foundation

Py_Initialize()

if let _ = try? TestPython() {
    print("SUCCESS")
} else {
    print("FAILURE")
}

var routines: [String: Routine] = [:]

// Setup routines
routines[MotorSpinner.commandLineName] = try MotorSpinner()


print("Welcome! To quit type exit")
while let userInput = readLine(strippingNewline: true),
    userInput != "exit" {
        if let routine = routines[userInput] {
            routine.start()
            routine.stop()
        } else {
            print("Unrecognized routine")
        }
}

