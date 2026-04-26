//
//  Event SequencerSpecific Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_SequencerSpecific_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    @Test
    func init_midi1FileRawBytes_Empty() throws {
        let bytes: [UInt8] = [0xFF, 0x7F, 0x00]
        
        let event = try MIDIFileEvent.SequencerSpecific(midi1FileRawBytes: bytes)
        
        #expect(event.data == [])
    }
    
    @Test
    func midi1FileRawBytes_Empty() {
        let event = MIDIFileEvent.SequencerSpecific(data: [])
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0xFF, 0x7F, 0x00])
    }
    
    @Test
    func init_midi1FileRawBytes_OneByte() throws {
        let bytes: [UInt8] = [0xFF, 0x7F, 0x01, 0x34]
        
        let event = try MIDIFileEvent.SequencerSpecific(midi1FileRawBytes: bytes)
        
        #expect(event.data == [0x34])
    }
    
    @Test
    func midi1FileRawBytes_OneByte() {
        let event = MIDIFileEvent.SequencerSpecific(data: [0x34])
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0xFF, 0x7F, 0x01, 0x34])
    }
    
    @Test
    func init_midi1FileRawBytes_127Bytes() throws {
        let data: [UInt8] = .init(repeating: 0x12, count: 127)
        
        let bytes: [UInt8] =
            [0xFF, 0x7F, // header
             0x7F]       // length: 127 bytes to follow
            + data       // data
        
        let event = try MIDIFileEvent.SequencerSpecific(midi1FileRawBytes: bytes)
        
        #expect(event.data == data)
    }
    
    @Test
    func midi1FileRawBytes_127Bytes() {
        let data: [UInt8] = .init(repeating: 0x12, count: 127)
        
        let event = MIDIFileEvent.SequencerSpecific(data: data)
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(
            bytes ==
                [0xFF, 0x7F, // header
                 0x7F]       // length: 127 bytes to follow
                + data   // data
        )
    }
    
    @Test
    func init_midi1FileRawBytes_128Bytes() throws {
        let data: [UInt8] = .init(repeating: 0x12, count: 128)
        
        let bytes: [UInt8] =
            [0xFF, 0x7F, // header
             0x81, 0x00] // length: 128 bytes to follow
            + data       // data
        
        let event = try MIDIFileEvent.SequencerSpecific(midi1FileRawBytes: bytes)
        
        #expect(event.data == data)
    }
    
    @Test
    func midi1FileRawBytes_128Bytes() {
        let data: [UInt8] = .init(repeating: 0x12, count: 128)
        
        let event = MIDIFileEvent.SequencerSpecific(data: data)
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(
            bytes ==
                [0xFF, 0x7F, // header
                 0x81, 0x00] // length: 128 bytes to follow
                + data   // data
        )
    }
}
