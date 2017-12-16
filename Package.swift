// swift-tools-version:3.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "led-blink",
    targets: [
	Target(
	    name: "led-blink",
	    dependencies: [ ])
        ],
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Python.git", majorVersion: 1),
        .Package(url: "https://github.com/uraimo/SwiftyGPIO.git", majorVersion: 0)
    ]
)
