//
//  Event SMPTETempo Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_SMPTETempo_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    @Test
    func init_midi1FileRawBytes_A() throws {
        let bytes: [UInt8] = [
            0xFF, 0x51, 0x03, // header
            0x00, 0x00, 0x28  // 24-bit tempo encoding
        ]
        
        let event = try MIDIFileEvent.SMPTETempo(midi1FileRawBytes: bytes)
        
        #expect(event.microsecondsPerQuarter == 40)
    }
    
    @Test
    func midi1FileRawBytes_A() {
        let event = MIDIFileEvent.SMPTETempo(microsecondsPerQuarter: 40)
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [
            0xFF, 0x51, 0x03, // header
            0x00, 0x00, 0x28  // 24-bit tempo encoding
        ])
    }
    
    @Test
    func init_midi1FileRawBytes_B() throws {
        let bytes: [UInt8] = [
            0xFF, 0x51, 0x03, // header
            0x00, 0x00, 0x28  // 24-bit tempo encoding
        ]
        
        let event = try MIDIFileEvent.SMPTETempo(midi1FileRawBytes: bytes)
        
        #expect(event.microsecondsPerQuarter == 40)
    }
    
    @Test
    func midi1FileRawBytes_B() {
        let event = MIDIFileEvent.SMPTETempo(microsecondsPerQuarter: 40)
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [
            0xFF, 0x51, 0x03, // header
            0x00, 0x00, 0x28  // 24-bit tempo encoding
        ])
    }
}
