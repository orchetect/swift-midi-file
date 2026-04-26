//
//  Event PortPrefix Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_PortPrefix_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    @Test
    func init_midi1FileRawBytes() throws {
        let bytes: [UInt8] = [0xFF, 0x21, 0x01, 0x02]
        
        let event = try MIDIFileEvent.PortPrefix(midi1FileRawBytes: bytes)
        
        #expect(event.port == 2)
    }
    
    @Test
    func midi1FileRawBytes() {
        let event = MIDIFileEvent.PortPrefix(port: 2)
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0xFF, 0x21, 0x01, 0x02])
    }
}
