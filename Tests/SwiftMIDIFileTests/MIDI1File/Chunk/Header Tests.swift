//
//  Header Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftMIDIInternals
@testable import SwiftMIDIFile
import Testing

@Suite struct Chunk_Header_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    @Test
    func init_Type0() throws {
        let header = MusicalMIDI1File.Header(
            format: .singleTrack,
            timebase: .musical(ticksPerQuarterNote: 720)
        )
        
        #expect(header.format == .singleTrack)
        #expect(header.timebase == .musical(ticksPerQuarterNote: 720))
        
        let rawData: [UInt8] = [0x4D, 0x54, 0x68, 0x64, // MThd header
                                0x00, 0x00, 0x00, 0x06, // length
                                0x00, 0x00, // format
                                0x00, 0x01, // track count
                                0x02, 0xD0] // timebase
        
        #expect(try header.midi1FileRawBytes(as: [UInt8].self, withTrackCount: 1) == rawData)
    }
    
    @Test
    func init_Type0_rawData() throws {
        let rawData: [UInt8] = [0x4D, 0x54, 0x68, 0x64, // MThd header
                                0x00, 0x00, 0x00, 0x06, // length
                                0x00, 0x00, // format
                                0x00, 0x01, // track count
                                0x02, 0xD0] // timebase
        
        let (header, trackCount) = try MusicalMIDI1File.Header.decode(midi1FileRawBytes: rawData, allowMultiTrackFormat0: false)
        
        #expect(header.format == .singleTrack)
        #expect(header.timebase == .musical(ticksPerQuarterNote: 720))
        #expect(trackCount == 1)
    }
    
    @Test
    func init_Type1() throws {
        let header = MusicalMIDI1File.Header(
            format: .multipleTracksSynchronous,
            timebase: .musical(ticksPerQuarterNote: 720)
        )
        
        #expect(header.format == .multipleTracksSynchronous)
        #expect(header.timebase == .musical(ticksPerQuarterNote: 720))
        
        let rawData: [UInt8] = [0x4D, 0x54, 0x68, 0x64, // MThd header
                                0x00, 0x00, 0x00, 0x06, // length
                                0x00, 0x01, // format
                                0x00, 0x02, // track count
                                0x02, 0xD0] // timebase
        
        #expect(try header.midi1FileRawBytes(as: [UInt8].self, withTrackCount: 2) == rawData)
    }
    
    @Test
    func init_Type1_rawData() throws {
        let rawData: [UInt8] = [0x4D, 0x54, 0x68, 0x64, // MThd header
                                0x00, 0x00, 0x00, 0x06, // length
                                0x00, 0x01, // format
                                0x00, 0x02, // track count
                                0x02, 0xD0] // timebase
        
        let (header, trackCount) = try MusicalMIDI1File.Header.decode(midi1FileRawBytes: rawData, allowMultiTrackFormat0: false)
        
        #expect(header.format == .multipleTracksSynchronous)
        #expect(header.timebase == .musical(ticksPerQuarterNote: 720))
        #expect(trackCount == 2)
    }
    
    @Test
    func init_Type2() throws {
        let header = MusicalMIDI1File.Header(
            format: .multipleTracksAsynchronous,
            timebase: .musical(ticksPerQuarterNote: 720)
        )
        
        #expect(header.format == .multipleTracksAsynchronous)
        #expect(header.timebase == .musical(ticksPerQuarterNote: 720))
        
        let rawData: [UInt8] = [0x4D, 0x54, 0x68, 0x64, // MThd header
                                0x00, 0x00, 0x00, 0x06, // length
                                0x00, 0x02, // format
                                0x00, 0x02, // track count
                                0x02, 0xD0] // timebase
        
        #expect(try header.midi1FileRawBytes(as: [UInt8].self, withTrackCount: 2) == rawData)
    }
    
    @Test
    func init_Type2_rawData() throws {
        let rawData: [UInt8] = [0x4D, 0x54, 0x68, 0x64, // MThd header
                                0x00, 0x00, 0x00, 0x06, // length
                                0x00, 0x02, // format
                                0x00, 0x02, // track count
                                0x02, 0xD0] // timebase
        
        let (header, trackCount) = try MusicalMIDI1File.Header.decode(midi1FileRawBytes: rawData, allowMultiTrackFormat0: false)

        #expect(header.format == .multipleTracksAsynchronous)
        #expect(header.timebase == .musical(ticksPerQuarterNote: 720))
        #expect(trackCount == 2)
    }
    
    // MARK: - Edge Cases
    
    @Test
    func init_LengthIntTooShort() {
        let rawData: [UInt8] = [0x4D, 0x54, 0x68, 0x64, // MThd header
                                0x00, 0x00, 0x00, 0x05, // length (wrong)
                                0x00, 0x00, // format
                                0x00, 0x01, // track count
                                0x02, 0xD0] // timebase
        
        #expect(throws: (any Error).self) {
            _ = try MusicalMIDI1File.Header.decode(midi1FileRawBytes: rawData, allowMultiTrackFormat0: false)
        }
        
        #expect(throws: (any Error).self) {
            _ = try MusicalMIDI1File.Header.decode(midi1FileRawBytesStream: rawData, allowMultiTrackFormat0: false)
        }
    }
    
    @Test
    func init_LengthIntTooLong() {
        let rawData: [UInt8] = [0x4D, 0x54, 0x68, 0x64, // MThd header
                                0x00, 0x00, 0x00, 0x07, // length (wrong)
                                0x00, 0x00, // format
                                0x00, 0x01, // track count
                                0x02, 0xD0] // timebase
        
        #expect(throws: (any Error).self) {
            _ = try MusicalMIDI1File.Header.decode(midi1FileRawBytes: rawData, allowMultiTrackFormat0: false)
        }
        
        #expect(throws: (any Error).self) {
            _ = try MusicalMIDI1File.Header.decode(midi1FileRawBytesStream: rawData, allowMultiTrackFormat0: false)
        }
    }
    
    @Test
    func init_LengthTooShort() {
        let rawData: [UInt8] = [0x4D, 0x54, 0x68, 0x64, // MThd header
                                0x00, 0x00, 0x00, 0x06, // length
                                0x00, 0x00, // format
                                0x00, 0x01, // track count
                                0x02] // timebase, but too few bytes (wrong)
        
        #expect(throws: (any Error).self) {
            _ = try MusicalMIDI1File.Header.decode(midi1FileRawBytes: rawData, allowMultiTrackFormat0: false)
        }
        
        #expect(throws: (any Error).self) {
            _ = try MusicalMIDI1File.Header.decode(midi1FileRawBytesStream: rawData, allowMultiTrackFormat0: false)
        }
    }
    
    @Test
    func init_MoreBytesThanExpected() {
        // valid header chunk, with an additional unexpected subsequent byte
        
        let rawData: [UInt8] = [0x4D, 0x54, 0x68, 0x64, // MThd header
                                0x00, 0x00, 0x00, 0x06, // length
                                0x00, 0x00, // format
                                0x00, 0x01, // track count
                                0x02, 0xD0, // timebase
                                0x01] // an extra unexpected byte
        
        // since the header is always a known total number of bytes,
        // decoding will succeed and ignore any additional subsequent bytes
        #expect(throws: Never.self) {
            _ = try MusicalMIDI1File.Header.decode(midi1FileRawBytes: rawData, allowMultiTrackFormat0: false)
        }
        
        #expect(throws: Never.self) {
            _ = try MusicalMIDI1File.Header.decode(midi1FileRawBytesStream: rawData, allowMultiTrackFormat0: false)
        }
    }
}
