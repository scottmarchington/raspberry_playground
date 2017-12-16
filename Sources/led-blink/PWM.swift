//
//  PWM.swift
//  led-blink
//
//  Created by Scott Marchington on 12/11/17.
//
//  Based off of https://github.com/adafruit/Adafruit-Motor-HAT-Python-Library
//  Commit f9e7c2592c5c720207b4e5040eb28e1628b48f49
//  Thanks, Adafruit!

import Foundation
import SwiftyGPIO

class PWM {
    enum Register {
        static let MODE1: Int              = 0x00
        static let MODE2: Int              = 0x01
        static let SUBADR1: Int            = 0x02
        static let SUBADR2: Int            = 0x03
        static let SUBADR3: Int            = 0x04
        static let PRESCALE: Int           = 0xFE
        static let LED0_ON_L: Int          = 0x06
        static let LED0_ON_H: Int          = 0x07
        static let LED0_OFF_L: Int         = 0x08
        static let LED0_OFF_H: Int         = 0x09
        static let ALL_LED_ON_L: Int       = 0xFA
        static let ALL_LED_ON_H: Int       = 0xFB
        static let ALL_LED_OFF_L: Int      = 0xFC
        static let ALL_LED_OFF_H: Int      = 0xFD
    }
    
    enum Bit {
        static let RESTART: UInt8 = 0x80
        static let SLEEP: UInt8   = 0x10
        static let ALLCALL: UInt8 = 0x01
        static let INVRT: UInt8   = 0x10
        static let OUTDRV: UInt8  = 0x04
    }
    
    let i2c: I2CInterface
    
    init?(_ address: Int = 0x60) {
        guard let i2cs = SwiftyGPIO.hardwareI2Cs(for: .RaspberryPi3) else {
            print("Couldn't find I2C interfaces")
            return nil
        }
        
        i2c = i2cs[1]
        
        guard i2c.isReachable(address) else {
            print("Address unreachable")
            return nil
        }
        
        print("Resetting PCA9685 MODE1 (without SLEEP) and MODE2")
        setAllPWM(on: 0, off: 0)
        print("PWMs all set to 0")
        i2c.writeByte(Register.MODE2, value: Bit.OUTDRV)
        print("wrote mode2")
        i2c.writeByte(Register.MODE1, value: Bit.ALLCALL)
        print("wrote mode1")
        usleep(5000) // wait for oscillator
        print("slept")
        var model = i2c.readByte(Register.MODE1)
        print("got mode1")
        model = model & ~Bit.SLEEP // wake up (reset sleep)
        i2c.writeByte(Register.MODE1, value: model)
        print("rewrote mode 1")
        usleep(5000) // wait for oscillator
    }
    
    func setPWMFrequency(_ frequency: Int) {
        print("Setting PWM Frequency")
        var prescaleVal: Float = 25_000_000.0 // 25MHz
        prescaleVal /= 4096.0 // 12-bit
        prescaleVal /= Float(frequency)
        prescaleVal -= 1.0
        
        print("Setting PWM frequency to \(frequency) Hz")
        print("Estimated pre-scale: \(prescaleVal)")
        
        let prescale = floorf(prescaleVal + 0.5)
        print("Final pre-scale: \(prescale)")
        
        let oldMode = i2c.readByte(Register.MODE1)
        let newMode = (oldMode & 0x7f) | 0x10 // sleep
        
        i2c.writeByte(Register.MODE1, value: newMode) // go to sleep
        i2c.writeByte(Register.PRESCALE, value: UInt8(floorf(prescale)))
        i2c.writeByte(Register.MODE1, value: oldMode)
        usleep(5000)
        
        i2c.writeByte(Register.MODE1, value: oldMode | 0x80)
    }
    
    func setPWM(_ channel: Int, on: Int, off: Int) {
        i2c.writeByte(Register.LED0_ON_L + 4*channel, value: UInt8(on & 0xFF))
        i2c.writeByte(Register.LED0_ON_H + 4*channel, value: UInt8(on >> 8))
        i2c.writeByte(Register.LED0_OFF_L + 4*channel, value: UInt8(off & 0xFF))
        i2c.writeByte(Register.LED0_OFF_H + 4*channel, value: UInt8(off >> 8))
    }
    
    func setAllPWM(on: Int, off: Int) {
        print("begin set all pwm")
        print("Register: \(Register.ALL_LED_ON_L)")
        let value = UInt8(on & 0xFF)
        print("Value:    \(value)")
        i2c.writeByte(Register.ALL_LED_ON_L, value: UInt8(on & 0xFF))
        print("set all led on l")
        i2c.writeByte(Register.ALL_LED_ON_H, value: UInt8(on >> 8))
        print("set all led on h")
        i2c.writeByte(Register.ALL_LED_OFF_L, value: UInt8(off & 0xFF))
        print("set all led off l")
        i2c.writeByte(Register.ALL_LED_OFF_H, value: UInt8(off >> 8))
        print("set all led off h")
    }
}
