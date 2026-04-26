//
//  Event PitchBend Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_PitchBend_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    @Test
    func init_midi1FileRawBytes_A() throws {
        let bytes: [UInt8] = [0xE0, 0x00, 0x40]
        
        let event = try MIDIFileEvent.PitchBend(midi1FileRawBytes: bytes)
        
        #expect(event.value == .midi1(.midpoint))
        #expect(event.channel == 0)
    }
    
    @Test
    func midi1FileRawBytes_A() {
        let event = MIDIFileEvent.PitchBend(
            value: .midi1(.midpoint),
            channel: 0
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0xE0, 0x00, 0x40])
    }
    
    @Test
    func init_midi1FileRawBytes_B() throws {
        let bytes: [UInt8] = [0xE1, 0x7F, 0x7F]
        
        let event = try MIDIFileEvent.PitchBend(midi1FileRawBytes: bytes)
        
        #expect(event.value == .midi1(.max))
        #expect(event.channel == 1)
    }
    
    @Test
    func midi1FileRawBytes_B() {
        let event = MIDIFileEvent.PitchBend(
            value: .midi1(.max),
            channel: 1
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0xE1, 0x7F, 0x7F])
    }
}
