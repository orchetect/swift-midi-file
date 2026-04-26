//
//  Event AnyTempo Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_AnyTempo_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    @Test
    func init_midi1FileRawBytes_A() throws {
        let bytes: [UInt8] = [
            0xFF, 0x51, 0x03, // header
            0x07, 0xA1, 0x20  // 24-bit tempo encoding
        ]
        
        let event = try MIDIFileEvent.AnyTempo(midi1FileRawBytes: bytes)
        
        guard case let .musical(tempo) = event else {
            Issue.record()
            return
        }
        
        #expect(tempo.bpm == 120.0)
    }
    
    @Test
    func midi1FileRawBytes_A() {
        let event: MIDIFileEvent.AnyTempo = .musical(.init(bpm: 120.0))
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [
            0xFF, 0x51, 0x03, // header
            0x07, 0xA1, 0x20  // 24-bit tempo encoding
        ])
    }
    
    @Test
    func init_midi1FileRawBytes_B() throws {
        let bytes: [UInt8] = [
            0xFF, 0x51, 0x03, // header
            0x0F, 0x42, 0x40  // 24-bit tempo encoding
        ]
        
        let event = try MIDIFileEvent.AnyTempo(midi1FileRawBytes: bytes)
        
        guard case let .musical(tempo) = event else {
            Issue.record()
            return
        }
        
        #expect(tempo.bpm == 60.0)
    }
    
    @Test
    func midi1FileRawBytes_B() {
        let event = MIDIFileEvent.MusicalTempo(bpm: 60.0)
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [
            0xFF, 0x51, 0x03, // header
            0x0F, 0x42, 0x40  // 24-bit tempo encoding
        ])
    }
}
