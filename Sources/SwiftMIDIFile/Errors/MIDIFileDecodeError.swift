//
//  MIDIFileDecodeError.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftMIDICore

public enum MIDIFileDecodeError: LocalizedError {
    case fileNotFound
    case malformedURL
    case fileReadError
    case malformed(_ verboseError: String)
    case notImplemented

    public var errorDescription: String? {
        switch self {
        case .fileNotFound:
            "File not found."
        case .malformedURL:
            "Malformed URL."
        case .fileReadError:
            "File read error."
        case let .malformed(verboseError):
            "Malformed: \(verboseError)"
        case .notImplemented:
            "Not implemented."
        }
    }
}

extension MIDIFileDecodeError: Equatable { }

extension MIDIFileDecodeError: Hashable { }

extension MIDIFileDecodeError: Sendable { }

// MARK: - Helpers

internal import SwiftDataParsing

extension DataParserProtocol {
    /// Utility:
    /// Wrapper to convert thrown data read errors to `DataParserError`.
    func toMIDIFileDecodeError<Result>(
        malformedReason: String? = nil,
        _ block: @autoclosure () throws(DataParserError) -> Result
    ) throws(MIDIFileDecodeError) -> Result {
        do throws(DataParserError) { return try block() }
        catch { throw .malformed(malformedReason ?? error.localizedDescription) }
    }
}
