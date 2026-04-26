//
//  Event RPN Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_RPN_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    // MARK: - With Data LSB
    
    @Test
    func init_Event_init_midi1FileRawBytes_SinglePacket_FullyFormedMessages() throws {
        let bytes: [UInt8] = [
            0xB1, 0x65, 0x00, // cc 101, chan 1
            0xB1, 0x64, 0x01, // cc 100, chan 1
            0xB1, 0x06, 0x00, // cc 6, chan 1
            0xB1, 0x26, 0x01  // cc 38, chan 1
        ]
        
        withKnownIssue("Removed RPN raw bytes init because there is no idiomatic way to deal with non-zero delta time values.") {
            let _ /* event */ = try MIDIFileEvent.RPN(midi1FileRawBytes: bytes)
        }
        
        // #expect(event.parameter == .channelFineTuning(1))
        // #expect(event.channel == 1)
    }
    
    @Test
    func init_Event_init_midi1FileRawBytes_SinglePacket_RunningStatus() throws {
        let bytes: [UInt8] = [
            0xB1, 0x65, 0x00, // cc 101, chan 1
            0x64, 0x01,       // cc 100, chan 1, running status 0xB1
            0x06, 0x00,       // cc 6, chan 1, running status 0xB1
            0x26, 0x01        // cc 38, chan 1, running status 0xB1
        ]
        
        withKnownIssue("Removed RPN raw bytes init because there is no idiomatic way to deal with non-zero delta time values.") {
            let _ /* event */ = try MIDIFileEvent.RPN(midi1FileRawBytes: bytes)
        }
        
        // #expect(event.parameter == .channelFineTuning(1))
        // #expect(event.channel == 1)
    }
    
    @Test
    func event_MIDI1SMFRawBytes_SinglePacket_FullyFormedMessages() {
        let event = MIDIFileEvent.RPN(
            .channelFineTuning(1),
            change: .absolute,
            channel: 1
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [
            0xB1, 0x65, 0x00, // cc 101, chan 1
            0x00,             // delta time
            0xB1, 0x64, 0x01, // cc 100, chan 1
            0x00,             // delta time
            0xB1, 0x06, 0x00, // cc 6, chan 1
            0x00,             // delta time
            0xB1, 0x26, 0x01  // cc 38, chan 1
        ])
    }
    
    // MARK: - No Data LSB
    
    @Test
    func init_Event_init_midi1FileRawBytes_SinglePacket_FullyFormedMessages_NoDataLSB() throws {
        let bytes: [UInt8] = [
            0xB2, 0x65, 0x05, // cc 101, chan 2
            0xB2, 0x64, 0x10, // cc 100, chan 2
            0xB2, 0x06, 0x08  // cc 6, chan 2
        ]
        
        withKnownIssue("Removed RPN raw bytes init because there is no idiomatic way to deal with non-zero delta time values.") {
            let _ /* event */ = try MIDIFileEvent.RPN(midi1FileRawBytes: bytes)
        }
        
        // #expect(
        //     event.parameter ==
        //         .raw(parameter: .init(msb: 0x05, lsb: 0x10), dataEntryMSB: 0x08, dataEntryLSB: nil)
        // )
        // #expect(event.channel == 2)
    }
    
    @Test
    func init_Event_init_midi1FileRawBytes_SinglePacket_RunningStatus_NoDataLSB() throws {
        let bytes: [UInt8] = [
            0xB2, 0x65, 0x05, // cc 101, chan 2
            0x64, 0x10,       // cc 100, chan 2, running status 0xB2
            0x06, 0x08        // cc 6, chan 2, running status 0xB2
        ]
        
        withKnownIssue("Removed RPN raw bytes init because there is no idiomatic way to deal with non-zero delta time values.") {
            let _ /* event */ = try MIDIFileEvent.RPN(midi1FileRawBytes: bytes)
        }
        
        // #expect(
        //     event.parameter ==
        //         .raw(parameter: .init(msb: 0x05, lsb: 0x10), dataEntryMSB: 0x08, dataEntryLSB: nil)
        // )
        // #expect(event.channel == 2)
    }
    
    @Test
    func event_MIDI1SMFRawBytes_SinglePacket_FullyFormedMessages_NoDataLSB() {
        let event = MIDIFileEvent.RPN(
            .raw(parameter: .init(msb: 0x05, lsb: 0x10), dataEntryMSB: 0x08, dataEntryLSB: nil),
            change: .absolute,
            channel: 2
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [
            0xB2, 0x65, 0x05, // cc 101, chan 2
            0x00,             // delta time
            0xB2, 0x64, 0x10, // cc 100, chan 2
            0x00,             // delta time
            0xB2, 0x06, 0x08  // cc 6, chan 2
        ])
    }
}
