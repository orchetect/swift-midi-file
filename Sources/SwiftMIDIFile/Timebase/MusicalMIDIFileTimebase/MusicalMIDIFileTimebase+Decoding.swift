//
//  MusicalMIDIFileTimebase+Decoding.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftMIDICore

extension MusicalMIDIFileTimebase {
    public static func decodeMIDI1FileHeader(
        midi1FileRawBytes: some DataProtocol,
        allowMultiTrackFormat0: Bool
    ) throws(MIDIFileDecodeError) -> (header: Header, trackCount: Int) {
        let (anyHeader, trackCount) = try MIDI1File<AnyMIDIFileTimebase>.Header.decode(
            midi1FileRawBytes: midi1FileRawBytes,
            allowMultiTrackFormat0: allowMultiTrackFormat0
        )

        switch anyHeader.timebase {
        case let .musical(timebase):
            let header = Header(format: anyHeader.format, timebase: timebase, additionalBytes: anyHeader.additionalBytes)
            return (header: header, trackCount: trackCount)

        default:
            throw .malformed("Unexpected file header timebase: \(anyHeader.timebase.description).")
        }
    }

    public static func decodeMIDI1FileHeader(
        midi1FileRawBytesStream stream: some DataProtocol,
        allowMultiTrackFormat0: Bool
    ) throws(MIDIFileDecodeError) -> (header: Header, trackCount: Int, bufferLength: Int) {
        let (anyHeader, trackCount, bufferLength) = try AnyMIDIFileTimebase.decodeMIDI1FileHeader(
            midi1FileRawBytesStream: stream,
            allowMultiTrackFormat0: allowMultiTrackFormat0
        )

        switch anyHeader.timebase {
        case let .musical(timebase):
            let header = Header(format: anyHeader.format, timebase: timebase, additionalBytes: anyHeader.additionalBytes)
            return (header: header, trackCount: trackCount, bufferLength: bufferLength)

        default:
            throw .malformed("Unexpected file header timebase: \(anyHeader.timebase.description).")
        }
    }
}
