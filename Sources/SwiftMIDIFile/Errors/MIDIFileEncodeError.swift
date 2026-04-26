//
//  MIDIFileEncodeError.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftMIDICore

public enum MIDIFileEncodeError: LocalizedError {
    /// Internal Inconsistency. `verboseError` contains the specific reason.
    case internalInconsistency(_ verboseError: String)

    public var errorDescription: String? {
        switch self {
        case let .internalInconsistency(verboseError):
            "Internal inconsistency: \(verboseError)"
        }
    }
}

extension MIDIFileEncodeError: Equatable { }

extension MIDIFileEncodeError: Hashable { }

extension MIDIFileEncodeError: Sendable { }
