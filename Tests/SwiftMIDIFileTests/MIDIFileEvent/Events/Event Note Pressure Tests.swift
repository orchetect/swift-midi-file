//
//  Event Note Pressure Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite
struct Event_NotePressure_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true

    @Test
    func init_midi1FileRawBytes_A() throws {
        let bytes: [UInt8] = [0xA0, 0x01, 0x40]

        let event = try MIDIFileEvent.NotePressure(midi1FileRawBytes: bytes)

        #expect(event.note.number == 1)
        #expect(event.amount == .midi1(0x40))
        #expect(event.channel == 0)
    }

    @Test
    func midi1FileRawBytes_A() {
        let event = MIDIFileEvent.NotePressure(
            note: 1,
            amount: .midi1(0x40),
            channel: 0
        )

        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)

        #expect(bytes == [0xA0, 0x01, 0x40])
    }

    @Test
    func init_midi1FileRawBytes_B() throws {
        let bytes: [UInt8] = [0xA1, 0x3C, 0x7F]

        let event = try MIDIFileEvent.NotePressure(midi1FileRawBytes: bytes)

        #expect(event.note.number == 60)
        #expect(event.amount == .midi1(0x7F))
        #expect(event.channel == 1)
    }

    @Test
    func midi1FileRawBytes_B() {
        let event = MIDIFileEvent.NotePressure(
            note: 60,
            amount: .midi1(0x7F),
            channel: 1
        )

        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)

        #expect(bytes == [0xA1, 0x3C, 0x7F])
    }
}
