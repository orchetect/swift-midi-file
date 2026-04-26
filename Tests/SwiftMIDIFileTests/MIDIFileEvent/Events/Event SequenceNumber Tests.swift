//
//  Event SequenceNumber Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_SequenceNumber_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    @Test
    func init_midi1FileRawBytes_A() throws {
        let bytes: [UInt8] = [0xFF, 0x00, 0x02, 0x00, 0x00]
        
        let event = try MIDIFileEvent.SequenceNumber(midi1FileRawBytes: bytes)
        
        #expect(event.sequence == 0x00)
    }
    
    @Test
    func midi1FileRawBytes_A() {
        let event = MIDIFileEvent.SequenceNumber(sequence: 0x00)
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0xFF, 0x00, 0x02, 0x00, 0x00])
    }
    
    @Test
    func init_midi1FileRawBytes_B() throws {
        let bytes: [UInt8] = [0xFF, 0x00, 0x02, 0x7F, 0xFF]
        
        let event = try MIDIFileEvent.SequenceNumber(midi1FileRawBytes: bytes)
        
        #expect(event.sequence == 0x7FFF)
    }
    
    @Test
    func midi1FileRawBytes_B() {
        let event = MIDIFileEvent.SequenceNumber(sequence: 0x7FFF)
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0xFF, 0x00, 0x02, 0x7F, 0xFF])
    }
}
