//
//  Header+Decoding.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

internal import SwiftDataParsing
internal import SwiftMIDIInternals
import Foundation
import SwiftMIDICore

extension MIDI1File.Header {
    /// Init from MIDI file header data.
    static func decode(
        midi1FileRawBytes: some DataProtocol,
        allowMultiTrackFormat0: Bool
    ) throws(MIDIFileDecodeError) -> (header: Self, trackCount: Int) {
        try Timebase.decodeMIDI1FileHeader(
            midi1FileRawBytes: midi1FileRawBytes,
            allowMultiTrackFormat0: allowMultiTrackFormat0
        )
    }

    /// Init from MIDI file data stream.
    static func decode(
        midi1FileRawBytesStream stream: some DataProtocol,
        allowMultiTrackFormat0: Bool
    ) throws(MIDIFileDecodeError) -> (header: Self, trackCount: Int, bufferLength: Int) {
        try Timebase.decodeMIDI1FileHeader(
            midi1FileRawBytesStream: stream,
            allowMultiTrackFormat0: allowMultiTrackFormat0
        )
    }
}
