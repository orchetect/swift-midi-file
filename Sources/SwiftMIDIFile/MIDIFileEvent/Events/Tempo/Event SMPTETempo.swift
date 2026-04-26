//
//  Event SMPTETempo.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

internal import SwiftDataParsing
import Foundation
import SwiftMIDICore

// ------------------------------------
// NOTE: When revising these documentation blocks, they are duplicated in:
//   - MIDIFileEvent enum case (`case keySignature(_:)`, etc.)
//   - MIDIFileEvent concrete payload structs (`KeySignature`, etc.)
//   - DocC documentation for each MIDIFileEvent type
// ------------------------------------

extension MIDIFileEvent {
    /// Tempo event for MIDI file tracks using SMPTE timecode timebase.
    /// For a format 1 MIDI file, tempo events should only occur within the first `MTrk` chunk.
    public struct SMPTETempo: Tempo {
        public typealias Timebase = SMPTEMIDIFileTimebase

        public var microsecondsPerQuarter: UInt32

        public init(microsecondsPerQuarter: UInt32) {
            self.microsecondsPerQuarter = microsecondsPerQuarter
        }
    }
}

// MARK: - MIDIFileEventPayload Overrides

extension MIDIFileEvent.SMPTETempo: MIDIFileEventPayload {
    public func asMIDIFileEvent() -> MIDIFileEvent {
        .tempo(.smpte(self))
    }

    // TODO: add specialized descriptions

    public var midiFileDescription: String {
        "\(microsecondsPerQuarter) ms/qtr" // TODO: replace with more specialized units
    }

    public var midiFileDebugDescription: String {
        "SMPTETempo(\(midiFileDescription))"
    }
}
