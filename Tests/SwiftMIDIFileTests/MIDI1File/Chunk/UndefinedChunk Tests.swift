//
//  UndefinedChunk Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
@testable import SwiftMIDIFile
import SwiftMIDIInternals
import Testing

@Suite
struct Chunk_UndefinedChunk_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true

    @Test
    func emptyData() throws {
        let id = "ABCD"
        let identifier = try #require(MIDI1FileChunkIdentifier(string: id))

        let track = MusicalMIDI1File.UndefinedChunk(identifier: identifier)

        #expect(track.identifier == identifier)

        let bytes: [UInt8] = [
            0x41, 0x42, 0x43, 0x44, // ABCD
            0x00, 0x00, 0x00, 0x00  // length: 0 bytes to follow
        ]

        // generate raw bytes
        let generatedData: [UInt8] = try track.midi1FileRawBytes(as: [UInt8].self)
        #expect(generatedData == bytes)

        // parse raw bytes
        let parsedTrack = try MusicalMIDI1File.UndefinedChunk(midi1FileRawBytesStream: generatedData)
        #expect(parsedTrack == parsedTrack)
    }

    @Test
    func withData() throws {
        let id = "ABCD"
        let identifier = try #require(MIDI1FileChunkIdentifier(string: id))

        let data: [UInt8] = [0x12, 0x34, 0x56, 0x78]

        let track = MusicalMIDI1File.UndefinedChunk(identifier: identifier, data: Data(data))

        #expect(track.identifier == identifier)

        let bytes: [UInt8] = [
            0x41, 0x42, 0x43, 0x44, // ABCD
            0x00, 0x00, 0x00, 0x04 // length: 4 bytes to follow
        ] + data  // data bytes

        // generate raw bytes
        let generatedData: [UInt8] = try track.midi1FileRawBytes(as: [UInt8].self)
        #expect(generatedData == bytes)

        // parse raw bytes
        let parsedTrack = try MusicalMIDI1File.UndefinedChunk(midi1FileRawBytesStream: generatedData)
        #expect(parsedTrack == parsedTrack)
    }
}
