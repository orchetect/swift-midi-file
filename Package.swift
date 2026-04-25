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
        .package(url: "https://github.com/orchetect/swift-midi-core", from: "0.0.0"),
        .package(url: "https://github.com/orchetect/swift-data-parsing", from: "0.1.2"),
        .package(url: "https://github.com/orchetect/swift-timecode", from: "3.1.0")
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
                "SwiftMIDIFile"
            ]
        )
    ]
)

#if canImport(Foundation) || canImport(CoreFoundation)
    #if canImport(Foundation)
        import class Foundation.ProcessInfo

        func getEnvironmentVar(_ name: String) -> String? {
            ProcessInfo.processInfo.environment[name]
        }

    #elseif canImport(CoreFoundation)
        import CoreFoundation

        func getEnvironmentVar(_ name: String) -> String? {
            guard let rawValue = getenv(name) else { return nil }
            return String(utf8String: rawValue)
        }
    #endif

    func isEnvironmentVarTrue(_ name: String) -> Bool {
        guard let value = getEnvironmentVar(name)?
            .trimmingCharacters(in: .whitespacesAndNewlines)
        else { return false }
        return ["true", "yes", "1"].contains(value.lowercased())
    }

    // MARK: - CI Pipeline

    if isEnvironmentVarTrue("GITHUB_ACTIONS") {
        for target in package.targets.filter(\.isTest) {
            if target.swiftSettings == nil { target.swiftSettings = [] }
            target.swiftSettings? += [.define("GITHUB_ACTIONS", .when(configuration: .debug))]
        }
    }
#endif
