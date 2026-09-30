// swift-tools-version: 6.0

import Foundation
import PackageDescription

let package = Package(
    name: "swift-midi-file",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "SwiftMIDIFile",
            targets: ["SwiftMIDIFile"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/orchetect/swift-midi-core", from: "1.0.0"),
        .package(url: "https://github.com/orchetect/swift-data-parsing", from: "0.1.2"),
        .package(url: "https://github.com/orchetect/swift-timecode", from: "3.1.3"),
        .package(url: "https://github.com/orchetect/swift-testing-extensions", from: "0.3.1")
    ],
    targets: [
        .target(
            name: "SwiftMIDIFile",
            dependencies: [
                .product(name: "SwiftMIDICore", package: "swift-midi-core"),
                .product(name: "SwiftMIDIInternals", package: "swift-midi-core"),
                .product(name: "SwiftDataParsing", package: "swift-data-parsing"),
                .product(name: "SwiftTimecodeCore", package: "swift-timecode")
            ],
            swiftSettings: [.define("DEBUG", .when(configuration: .debug))]
        ),
        .testTarget(
            name: "SwiftMIDIFileTests",
            dependencies: [
                "SwiftMIDIFile",
                .product(name: "TestingExtensions", package: "swift-testing-extensions")
            ]
        )
    ]
)

// MARK: - Utilities

func hasEnvironmentVariable(_ name: String) -> Bool {
    ProcessInfo.processInfo.environment[name] != nil
}

// MARK: - CI Pipeline

if hasEnvironmentVariable("GITHUB_ACTIONS") {
    for target in package.targets {
        if target.swiftSettings == nil { target.swiftSettings = [] }
        target.swiftSettings? += [.define("GITHUB_ACTIONS", .when(configuration: .debug))]
    }
}
