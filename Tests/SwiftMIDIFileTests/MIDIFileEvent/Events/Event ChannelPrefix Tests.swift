//
//  Event ChannelPrefix Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_ChannelPrefix_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    @Test
    func init_midi1FileRawBytes() throws {
        let bytes: [UInt8] = [0xFF, 0x20, 0x01, 0x02]
        
        let event = try MIDIFileEvent.ChannelPrefix(midi1FileRawBytes: bytes)
        
        #expect(event.channel == 2)
    }
    
    @Test
    func midi1FileRawBytes() {
        let event = MIDIFileEvent.ChannelPrefix(channel: 2)
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0xFF, 0x20, 0x01, 0x02])
    }
}
