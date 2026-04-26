//
//  DataParser+MIDI1File.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

internal import SwiftDataParsing
import Foundation

extension DataParserProtocol where DataRange: DataProtocol {
    /// Convenience to decode a variable-length value.
    mutating func midi1FileVariableLengthValue() throws(MIDIFileDecodeError) -> Int {
        let readAheadCount = remainingByteCount.clamped(to: 1 ... 4)

        let lengthBytes = try toMIDIFileDecodeError(
            malformedReason: "Could not extract variable-length value length.",
            read(bytes: readAheadCount, advance: false)
        )
        guard let valueAndLength = lengthBytes.midi1FileVariableLengthValue()
        else {
            throw .malformed(
                "Could not extract variable length."
            )
        }
        try toMIDIFileDecodeError(seek(by: valueAndLength.byteLength))

        return valueAndLength.value
    }
}
