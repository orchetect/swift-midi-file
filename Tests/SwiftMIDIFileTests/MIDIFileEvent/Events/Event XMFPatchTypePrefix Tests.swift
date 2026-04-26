//
//  Event XMFPatchTypePrefix Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_XMFPatchTypePrefix_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    @Test
    func init_midi1FileRawBytes_A() throws {
        let bytes: [UInt8] = [
            0xFF, 0x60, // header
            0x01,       // length (always 1)
            0x01        // param
        ]
        
        let event = try MIDIFileEvent.XMFPatchTypePrefix(midi1FileRawBytes: bytes)
        
        #expect(event.patchSet == .generalMIDI1)
    }
    
    @Test
    func midi1FileRawBytes_A() {
        let event = MIDIFileEvent.XMFPatchTypePrefix(patchSet: .generalMIDI1)
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [
            0xFF, 0x60, // header
            0x01,       // length (always 1)
            0x01        // param
        ])
    }
    
    @Test
    func init_midi1FileRawBytes_B() throws {
        let bytes: [UInt8] = [
            0xFF, 0x60, // header
            0x01,       // length (always 1)
            0x02        // param
        ]
        
        let event = try MIDIFileEvent.XMFPatchTypePrefix(midi1FileRawBytes: bytes)
        
        #expect(event.patchSet == .generalMIDI2)
    }
    
    @Test
    func midi1FileRawBytes_B() {
        let event = MIDIFileEvent.XMFPatchTypePrefix(patchSet: .generalMIDI2)
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [
            0xFF, 0x60, // header
            0x01,       // length (always 1)
            0x02       // param
        ])
    }
    
    // MARK: - Edge Cases
    
    @Test
    func undefinedParam() {
        let bytes: [UInt8] = [
            0xFF, 0x60, // header
            0x01,       // length (always 1)
            0x20        // param (undefined)
        ]
        
        #expect(throws: (any Error).self) {
            try MIDIFileEvent.XMFPatchTypePrefix(midi1FileRawBytes: bytes)
        }
    }
}
