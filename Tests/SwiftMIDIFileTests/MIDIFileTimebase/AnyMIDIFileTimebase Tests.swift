//
//  AnyMIDIFileTimebase Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
@testable import SwiftMIDIFile
import SwiftMIDIInternals
import Testing

@Suite
struct AnyMIDIFileTimebase_Tests {
    @Test
    func musical_Init_UInt8Array_Unwrap() {
        let timebase: MusicalMIDI1File.Timebase = .musical(ticksPerQuarterNote: 480)
        let rawData: [UInt8] = timebase.midi1FileRawBytes(as: [UInt8].self)

        guard case let .musical(unwrappedTimebase) = AnyMIDIFileTimebase(midi1FileRawBytes: rawData)
        else { Issue.record(); return }

        #expect(unwrappedTimebase.ticksPerQuarterNote == 480)
    }

    @Test
    func musical_Init_Data_Unwrap() {
        let timebase: MusicalMIDI1File.Timebase = .musical(ticksPerQuarterNote: 480)
        let rawData: Data = timebase.midi1FileRawBytes(as: Data.self)

        guard case let .musical(unwrappedTimebase) = AnyMIDIFileTimebase(midi1FileRawBytes: rawData)
        else { Issue.record(); return }

        #expect(unwrappedTimebase.ticksPerQuarterNote == 480)
    }

    @Test
    func musical_midi1FileRawBytes() {
        let timebase: MusicalMIDI1File.Timebase = .musical(ticksPerQuarterNote: 480)
        let rawData: [UInt8] = [0x01, 0xE0]
        #expect(timebase.midi1FileRawBytes(as: [UInt8].self) == rawData)
    }

    @Test
    func smpte_Init_UInt8Array_Unwrap() {
        let timebase: SMPTEMIDI1File.Timebase = .smpte(frameRate: .fps25, ticksPerFrame: 80)
        let rawData: [UInt8] = timebase.midi1FileRawBytes(as: [UInt8].self)

        guard case let .smpte(unwrappedTimebase) = AnyMIDIFileTimebase(midi1FileRawBytes: rawData)
        else { Issue.record(); return }

        #expect(unwrappedTimebase.frameRate == .fps25)
        #expect(unwrappedTimebase.ticksPerFrame == 80)
    }

    @Test
    func smpte_Init_Data_Unwrap() {
        let timebase: SMPTEMIDI1File.Timebase = .smpte(frameRate: .fps25, ticksPerFrame: 80)
        let rawData: Data = timebase.midi1FileRawBytes(as: Data.self)

        guard case let .smpte(unwrappedTimebase) = AnyMIDIFileTimebase(midi1FileRawBytes: rawData)
        else { Issue.record(); return }

        #expect(unwrappedTimebase.frameRate == .fps25)
        #expect(unwrappedTimebase.ticksPerFrame == 80)
    }

    @Test
    func smpte_midi1FileRawBytes() {
        let timebase: SMPTEMIDI1File.Timebase = .smpte(frameRate: .fps25, ticksPerFrame: 80)
        let rawData: [UInt8] = [0b11100111, 0x50]
        #expect(timebase.midi1FileRawBytes(as: [UInt8].self) == rawData)
    }
}
