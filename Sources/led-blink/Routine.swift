//
//  Routine.swift
//  led-blink
//
//  Created by Scott Marchington on 12/3/17.
//

import Foundation
import SwiftyGPIO

/**
 Defines a basic routine
 */
protocol Routine: class {
    static var commandLineName: String { get }
    static var humanReadableName: String { get }
    
    func start()
    func stop()
}
