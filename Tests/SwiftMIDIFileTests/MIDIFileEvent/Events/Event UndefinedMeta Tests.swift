//
//  Event UndefinedMeta Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite
struct Event_UndefinedMeta_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true

    @Test
    func init_midi1FileRawBytes_EmptyData() throws {
        let bytes: [UInt8] = [
            0xFF, 0x30, // unknown/undefined meta type 0x30
            0x00        // length: 0 bytes to follow
        ]

        let event = try MIDIFileEvent.UndefinedMeta(midi1FileRawBytes: bytes)

        #expect(event.metaType == 0x30)
        #expect(event.data == [])
    }

    @Test
    func midi1FileRawBytes_EmptyData() {
        let event = MIDIFileEvent.UndefinedMeta(
            metaType: 0x30,
            data: []
        )

        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)

        #expect(bytes == [
            0xFF, 0x30, // unknown/undefined meta type 0x30
            0x00        // length: 0 bytes to follow
        ])
    }

    @Test
    func init_midi1FileRawBytes_WithData() throws {
        let bytes: [UInt8] = [
            0xFF, 0x30, // unknown/undefined meta type 0x30
            0x01,       // length: 1 bytes to follow
            0x12        // data byte
        ]

        let event = try MIDIFileEvent.UndefinedMeta(midi1FileRawBytes: bytes)

        #expect(event.metaType == 0x30)
        #expect(event.data == [0x12])
    }

    @Test
    func midi1FileRawBytes_WithData() {
        let event = MIDIFileEvent.UndefinedMeta(
            metaType: 0x30,
            data: [0x12]
        )

        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)

        #expect(bytes == [
            0xFF, 0x30, // unknown/undefined meta type 0x30
            0x01,       // length: 1 bytes to follow
            0x12        // data byte
        ])
    }

    @Test
    func init_midi1FileRawBytes_127Bytes() throws {
        let data: [UInt8] = .init(repeating: 0x12, count: 127)

        let bytes: [UInt8] =
            [0xFF, 0x30, // unknown/undefined meta type 0x30
             0x7F]       // length: 127 bytes to follow
            + data       // data

        let event = try MIDIFileEvent.UndefinedMeta(midi1FileRawBytes: bytes)

        #expect(event.metaType == 0x30)
        #expect(event.data == data)
    }

    @Test
    func midi1FileRawBytes_127Bytes() {
        let data: [UInt8] = .init(repeating: 0x12, count: 127)

        let event = MIDIFileEvent.UndefinedMeta(
            metaType: 0x30,
            data: data
        )

        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)

        #expect(
            bytes ==
                [0xFF, 0x30, // unknown/undefined meta type 0x30
                 0x7F]       // length: 127 bytes to follow
                + data   // data
        )
    }

    @Test
    func init_midi1FileRawBytes_128Bytes() throws {
        let data: [UInt8] = .init(repeating: 0x12, count: 128)

        let bytes: [UInt8] =
            [0xFF, 0x30, // unknown/undefined meta type 0x30
             0x81, 0x00] // length: 128 bytes to follow
            + data       // data

        let event = try MIDIFileEvent.UndefinedMeta(midi1FileRawBytes: bytes)

        #expect(event.metaType == 0x30)
        #expect(event.data == data)
    }

    @Test
    func midi1SMFRawBytes_128Bytes() {
        let data: [UInt8] = .init(repeating: 0x12, count: 128)

        let event = MIDIFileEvent.UndefinedMeta(
            metaType: 0x30,
            data: data
        )

        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)

        #expect(
            bytes ==
                [0xFF, 0x30, // unknown/undefined meta type 0x30
                 0x81, 0x00] // length: 128 bytes to follow
                + data   // data
        )
    }
}
