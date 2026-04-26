//
//  Data+MIDI1File Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Data_And_MIDI1File_Tests {
    @Test
    func encodeVariableLengthValue() {
        #expect([UInt8](midi1FileVariableLengthValue: 0) == [0x00])
        #expect([UInt8](midi1FileVariableLengthValue: 1) == [0x01])
        #expect([UInt8](midi1FileVariableLengthValue: 64) == [0x40])
        
        #expect([UInt8](midi1FileVariableLengthValue: 127) == [0x7F])
        #expect([UInt8](midi1FileVariableLengthValue: 128) == [0x81, 0x00])
        #expect([UInt8](midi1FileVariableLengthValue: 129) == [0x81, 0x01])
        
        #expect([UInt8](midi1FileVariableLengthValue: 255) == [0x81, 0x7F])
        #expect([UInt8](midi1FileVariableLengthValue: 256) == [0x82, 0x00])
        #expect([UInt8](midi1FileVariableLengthValue: 257) == [0x82, 0x01])
        
        #expect([UInt8](midi1FileVariableLengthValue: 16383) == [0xFF, 0x7F])
        #expect([UInt8](midi1FileVariableLengthValue: 16384) == [0x81, 0x80, 0x00])
        #expect([UInt8](midi1FileVariableLengthValue: 16385) == [0x81, 0x80, 0x01])
    }
    
    @Test
    func decodeVariableLengthValue_Empty() {
        #expect([UInt8]().midi1FileVariableLengthValue() == nil)
    }
    
    @Test
    func decodeVariableLengthValue() {
        // repeat the test for:
        //   1. empty trailing bytes (so input bytes comprise only the variable length value)
        //   2. one or more trailing bytes existing in the input buffer
        // the outcome should be the same in either case.
        
        let trailingBytesCases: [[UInt8]] = [[], [0x80], [0x12, 0x23]]
        
        for trailingBytes in trailingBytesCases {
            let decode = { ($0 + trailingBytes).midi1FileVariableLengthValue() }
            
            // 1 byte: max 7-bit value
            
            #expect(decode([0x00])?.value == 0)
            #expect(decode([0x00])?.byteLength == 1)
            
            #expect(decode([0x01])?.value == 1)
            #expect(decode([0x01])?.byteLength == 1)
            
            #expect(decode([0x40])?.value == 64)
            #expect(decode([0x40])?.byteLength == 1)
            
            #expect(decode([0x7F])?.value == 127)
            #expect(decode([0x7F])?.byteLength == 1)
            
            // 2 bytes: max 14-bit value
            
            #expect(decode([0x81, 0x00])?.value == 128)
            #expect(decode([0x81, 0x00])?.byteLength == 2)
            
            #expect(decode([0x81, 0x01])?.value == 129)
            #expect(decode([0x81, 0x00])?.byteLength == 2)
            
            #expect(decode([0x81, 0x7F])?.value == 255)
            #expect(decode([0x81, 0x7F])?.byteLength == 2)
            
            #expect(decode([0x82, 0x00])?.value == 256)
            #expect(decode([0x82, 0x00])?.byteLength == 2)
            
            #expect(decode([0x82, 0x01])?.value == 257)
            #expect(decode([0x82, 0x01])?.byteLength == 2)
            
            #expect(decode([0xFF, 0x7F])?.value == 16383)
            #expect(decode([0xFF, 0x7F])?.byteLength == 2)
            
            // 3 bytes: max 21-bit value
            
            #expect(decode([0x81, 0x80, 0x00])?.value == 16384)
            #expect(decode([0x81, 0x80, 0x00])?.byteLength == 3)
            
            #expect(decode([0x81, 0x80, 0x01])?.value == 16385)
            #expect(decode([0x81, 0x80, 0x01])?.byteLength == 3)
            
            // 4 bytes: max 28-bit value
            
            #expect(decode([0xFF, 0xFF, 0xFF, 0x7F])?.value == 268_435_455)
            #expect(decode([0xFF, 0xFF, 0xFF, 0x7F])?.byteLength == 4)
        }
    }
    
    @Test
    func decodeVariableLengthValue_EdgeCase() {
        // ensure setting the top bit with no bytes following does not crash
        
        #expect(([0x80] as [UInt8]).midi1FileVariableLengthValue() == nil)
    }
}
