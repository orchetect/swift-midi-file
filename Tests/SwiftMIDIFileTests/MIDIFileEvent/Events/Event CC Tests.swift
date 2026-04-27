//
//  Event CC Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite
struct Event_CC_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true

    @Test
    func init_midi1FileRawBytes_A() throws {
        let bytes: [UInt8] = [0xB0, 0x01, 0x40]

        let event = try MIDIFileEvent.CC(midi1FileRawBytes: bytes)

        #expect(event.controller == .modWheel) // CC 1
        #expect(event.value == .midi1(0x40))
        #expect(event.channel == 0)
    }

    @Test
    func midi1FileRawBytes_A() {
        let event = MIDIFileEvent.CC(
            controller: .modWheel,
            value: .midi1(0x40),
            channel: 0
        )

        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)

        #expect(bytes == [0xB0, 0x01, 0x40])
    }

    @Test
    func init_midi1FileRawBytes_B() throws {
        let bytes: [UInt8] = [0xB1, 0x0B, 0x7F]

        let event = try MIDIFileEvent.CC(midi1FileRawBytes: bytes)

        #expect(event.controller == .expression) // CC 11
        #expect(event.value == .midi1(0x7F))
        #expect(event.channel == 1)
    }

    @Test
    func midi1FileRawBytes_B() {
        let event = MIDIFileEvent.CC(
            controller: .expression,
            value: .midi1(0x7F),
            channel: 1
        )

        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)

        #expect(bytes == [0xB1, 0x0B, 0x7F])
    }
}
