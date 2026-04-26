//
//  Event KeySignature Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_KeySignature_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    @Test
    func init_midi1FileRawBytes_A() throws {
        let bytes: [UInt8] = [0xFF, 0x59, 0x02, 4, 0x00]
        
        let event = try MIDIFileEvent.KeySignature(midi1FileRawBytes: bytes)
        
        #expect(event.flatsOrSharps == 4)
        #expect(event.isMajor)
    }
    
    @Test
    func midi1FileRawBytes_A() throws {
        let event = try #require(MIDIFileEvent.KeySignature(flatsOrSharps: 4, isMajor: true))
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0xFF, 0x59, 0x02, 4, 0x00])
    }
    
    @Test
    func init_midi1FileRawBytes_B() throws {
        let bytes: [UInt8] = [0xFF, 0x59, 0x02, 0xFD, 0x01]
        
        let event = try MIDIFileEvent.KeySignature(midi1FileRawBytes: bytes)
        
        #expect(event.flatsOrSharps == -3)
        #expect(!event.isMajor)
    }
    
    @Test
    func midi1FileRawBytes_B() throws {
        let event = try #require(MIDIFileEvent.KeySignature(flatsOrSharps: -3, isMajor: false))
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0xFF, 0x59, 0x02, 0xFD, 0x01])
    }
}
