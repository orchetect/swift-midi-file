//
//  Event ProgramChange Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_ProgramChange_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    @Test
    func init_midi1FileRawBytes_A() throws {
        let bytes: [UInt8] = [0xC0, 0x40]
        
        let event = try MIDIFileEvent.ProgramChange(midi1FileRawBytes: bytes)
        
        #expect(event.program == 0x40)
        #expect(event.channel == 0)
    }
    
    @Test
    func midi1FileRawBytes_A() {
        let event = MIDIFileEvent.ProgramChange(
            program: 0x40,
            bank: .noBankSelect,
            channel: 0
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0xC0, 0x40])
    }
    
    @Test
    func init_midi1FileRawBytes_B() throws {
        let bytes: [UInt8] = [0xC1, 0x7F]
        
        let event = try MIDIFileEvent.ProgramChange(midi1FileRawBytes: bytes)
        
        #expect(event.program == 0x7F)
        #expect(event.channel == 1)
    }
    
    @Test
    func midi1FileRawBytes_B() {
        let event = MIDIFileEvent.ProgramChange(
            program: 0x7F,
            bank: .noBankSelect,
            channel: 1
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0xC1, 0x7F])
    }
}
