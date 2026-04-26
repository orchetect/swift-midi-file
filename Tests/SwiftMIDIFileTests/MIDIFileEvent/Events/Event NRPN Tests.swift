//
//  Event NRPN Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_NRPN_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    // MARK: - With Data LSB
    
    @Test
    func init_Event_init_midi1FileRawBytes_SinglePacket_FullyFormedMessages() throws {
        let bytes: [UInt8] = [
            0xB1, 0x63, 0x00, // cc 99, chan 1
            0xB1, 0x62, 0x01, // cc 98, chan 1
            0xB1, 0x06, 0x02, // cc 6, chan 1
            0xB1, 0x26, 0x03  // cc 38, chan 1
        ]
        
        withKnownIssue("Removed NRPN raw bytes init because there is no idiomatic way to deal with non-zero delta time values.") {
            let _ /* event */ = try MIDIFileEvent.NRPN(midi1FileRawBytes: bytes)
        }
        
        // #expect(
        //     event.parameter ==
        //         .raw(parameter: .init(msb: 0x00, lsb: 0x01), dataEntryMSB: 0x02, dataEntryLSB: 0x03)
        // )
        // #expect(event.channel == 1)
    }
    
    @Test
    func init_Event_init_midi1FileRawBytes_SinglePacket_RunningStatus() throws {
        let bytes: [UInt8] = [
            0xB1, 0x63, 0x00, // cc 99, chan 1
            0x62, 0x01,       // cc 98, chan 1, running status 0xB1
            0x06, 0x02,       // cc 6, chan 1, running status 0xB1
            0x26, 0x03        // cc 38, chan 1, running status 0xB1
        ]
        
        withKnownIssue("Removed NRPN raw bytes init because there is no idiomatic way to deal with non-zero delta time values.") {
            let _ /* event */ = try MIDIFileEvent.NRPN(midi1FileRawBytes: bytes)
        }
        
        // #expect(
        //     event.parameter ==
        //         .raw(parameter: .init(msb: 0x00, lsb: 0x01), dataEntryMSB: 0x02, dataEntryLSB: 0x03)
        // )
        // #expect(event.channel == 1)
    }
    
    @Test
    func event_MIDI1SMFRawBytes_SinglePacket_FullyFormedMessages() {
        let event = MIDIFileEvent.NRPN(
            .raw(parameter: .init(msb: 0x00, lsb: 0x01), dataEntryMSB: 0x02, dataEntryLSB: 0x03),
            change: .absolute,
            channel: 1
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [
            0xB1, 0x63, 0x00, // cc 99, chan 1
            0x00,             // delta time
            0xB1, 0x62, 0x01, // cc 98, chan 1
            0x00,             // delta time
            0xB1, 0x06, 0x02, // cc 6, chan 1
            0x00,             // delta time
            0xB1, 0x26, 0x03  // cc 38, chan 1
        ])
    }
    
    // MARK: - No Data LSB
    
    @Test
    func init_Event_init_midi1FileRawBytes_SinglePacket_FullyFormedMessages_NoDataLSB() throws {
        let bytes: [UInt8] = [
            0xB2, 0x63, 0x05, // cc 99, chan 2
            0xB2, 0x62, 0x10, // cc 98, chan 2
            0xB2, 0x06, 0x08  // cc 6, chan 2
        ]
        
        withKnownIssue("Removed NRPN raw bytes init because there is no idiomatic way to deal with non-zero delta time values.") {
            let _ /* event */ = try MIDIFileEvent.NRPN(midi1FileRawBytes: bytes)
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
            0xB2, 0x63, 0x05, // cc 99, chan 2
            0x62, 0x10,       // cc 98, chan 2, running status 0xB2
            0x06, 0x08        // cc 6, chan 2, running status 0xB2
        ]
        
        withKnownIssue("Removed NRPN raw bytes init because there is no idiomatic way to deal with non-zero delta time values.") {
            let _ /* event */ = try MIDIFileEvent.NRPN(midi1FileRawBytes: bytes)
        }
        
        // #expect(
        //     event.parameter ==
        //         .raw(parameter: .init(msb: 0x05, lsb: 0x10), dataEntryMSB: 0x08, dataEntryLSB: nil)
        // )
        // #expect(event.channel == 2)
    }
    
    @Test
    func event_MIDI1SMFRawBytes_SinglePacket_FullyFormedMessages_NoDataLSB() {
        let event = MIDIFileEvent.NRPN(
            .raw(parameter: .init(msb: 0x05, lsb: 0x10), dataEntryMSB: 0x08, dataEntryLSB: nil),
            change: .absolute,
            channel: 2
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [
            0xB2, 0x63, 0x05, // cc 99, chan 2
            0x00,             // delta time
            0xB2, 0x62, 0x10, // cc 98, chan 2
            0x00,             // delta time
            0xB2, 0x06, 0x08  // cc 6, chan 2
        ])
    }
}

@Suite struct Event_NRPN_Track_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    // MARK: - With Data LSB
    
    @Test
    func init_Event_init_midi1FileRawBytes_SinglePacket_FullyFormedMessages() async throws {
        let bytes: [UInt8] = [
            0x4D, 0x54, 0x72, 0x6B, // MTrk
            0x00, 0x00, 0x00, 0x14, // length: 20 bytes to follow
            
            0x00,                   // delta time
            0xB1, 0x63, 0x00,       // cc 99, chan 1
            0x00,                   // delta time
            0xB1, 0x62, 0x01,       // cc 98, chan 1
            0x00,                   // delta time
            0xB1, 0x06, 0x02,       // cc 6, chan 1
            0x00,                   // delta time
            0xB1, 0x26, 0x03,       // cc 38, chan 1
            
            0x00,                   // delta time prior to chunk end
            0xFF, 0x2F, 0x00        // chunk end
        ]
        
        // (not implemented, so we need to test parsing using a track instead)
        // let event = try MIDIFileEvent.NRPN(midi1FileRawBytes: bytes)
        
        let timebase: MusicalMIDI1File.Timebase = .musical(ticksPerQuarterNote: 960)
        
        let parsedTrackA = try #require(try MusicalMIDI1File.Track(
            midi1FileRawBytesStream: bytes,
            timebase: timebase,
            options: .init(bundleRPNAndNRPNEvents: true)
        ))
        #expect(parsedTrackA.events.count == 1)
        guard case let .nrpn(event) = parsedTrackA.events[0].event else { Issue.record(); return }
        let delta = parsedTrackA.events[0].delta
        
        #expect(delta.ticks(using: timebase) == 0)
        #expect(
            event.parameter ==
                .raw(parameter: .init(msb: 0x00, lsb: 0x01), dataEntryMSB: 0x02, dataEntryLSB: 0x03)
        )
        #expect(event.channel == 1)
    }
    
    @Test
    func init_Event_init_midi1FileRawBytes_SinglePacket_RunningStatus() async throws {
        let bytes: [UInt8] = [
            0x4D, 0x54, 0x72, 0x6B, // MTrk
            0x00, 0x00, 0x00, 0x11, // length: 17 bytes to follow
            
            0x00,                   // delta time
            0xB1, 0x63, 0x00,       // cc 99, chan 1
            0x00,                   // delta time
            0x62, 0x01,             // cc 98, chan 1, running status 0xB1
            0x00,                   // delta time
            0x06, 0x02,             // cc 6, chan 1, running status 0xB1
            0x00,                   // delta time
            0x26, 0x03,             // cc 38, chan 1, running status 0xB1
            
            0x00,                   // delta time prior to chunk end
            0xFF, 0x2F, 0x00        // chunk end
        ]
        
        // (not implemented, so we need to test parsing using a track instead)
        // let event = try MIDIFileEvent.NRPN(midi1FileRawBytes: bytes)
        
        let timebase: MusicalMIDI1File.Timebase = .musical(ticksPerQuarterNote: 960)
        
        let parsedTrackA = try #require(try MusicalMIDI1File.Track(
            midi1FileRawBytesStream: bytes,
            timebase: timebase,
            options: .init(bundleRPNAndNRPNEvents: true)
        ))
        #expect(parsedTrackA.events.count == 1)
        guard case let .nrpn(event) = parsedTrackA.events[0].event else { Issue.record(); return }
        let delta = parsedTrackA.events[0].delta
        
        #expect(delta.ticks(using: timebase) == 0)
        #expect(
            event.parameter ==
                .raw(parameter: .init(msb: 0x00, lsb: 0x01), dataEntryMSB: 0x02, dataEntryLSB: 0x03)
        )
        #expect(event.channel == 1)
    }
    
    @Test
    func event_MIDI1SMFRawBytes_SinglePacket_FullyFormedMessages() async {
        let event = MIDIFileEvent.NRPN(
            .raw(parameter: .init(msb: 0x00, lsb: 0x01), dataEntryMSB: 0x02, dataEntryLSB: 0x03),
            change: .absolute,
            channel: 1
        )
        
        // (first delta time is omitted as always, it synthesizes zero delta times for subsequent events)
        let bytes = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [
            0xB1, 0x63, 0x00, // cc 99, chan 1
            0x00,             // delta time
            0xB1, 0x62, 0x01, // cc 98, chan 1
            0x00,             // delta time
            0xB1, 0x06, 0x02, // cc 6, chan 1
            0x00,             // delta time
            0xB1, 0x26, 0x03  // cc 38, chan 1
        ])
    }
    
    // MARK: - No Data LSB
    
    @Test
    func init_Event_init_midi1FileRawBytes_SinglePacket_FullyFormedMessages_NoDataLSB() async throws {
        let bytes: [UInt8] = [
            0x4D, 0x54, 0x72, 0x6B, // MTrk
            0x00, 0x00, 0x00, 0x10, // length: 16 bytes to follow
            
            0x00,                   // delta time
            0xB2, 0x63, 0x05,       // cc 99, chan 2
            0x00,                   // delta time
            0xB2, 0x62, 0x10,       // cc 98, chan 2
            0x00,                   // delta time
            0xB2, 0x06, 0x08,       // cc 6, chan 2
            
            0x00,                   // delta time prior to chunk end
            0xFF, 0x2F, 0x00        // chunk end
        ]
        
        // (not implemented, so we need to test parsing using a track instead)
        // let event = try MIDIFileEvent.NRPN(midi1FileRawBytes: bytes)
        
        let timebase: MusicalMIDI1File.Timebase = .musical(ticksPerQuarterNote: 960)
        
        let parsedTrackA = try #require(try MusicalMIDI1File.Track(
            midi1FileRawBytesStream: bytes,
            timebase: timebase,
            options: .init(bundleRPNAndNRPNEvents: true)
        ))
        #expect(parsedTrackA.events.count == 1)
        guard case let .nrpn(event) = parsedTrackA.events[0].event else { Issue.record(); return }
        let delta = parsedTrackA.events[0].delta
        
        #expect(delta.ticks(using: timebase) == 0)
        #expect(
            event.parameter ==
                .raw(parameter: .init(msb: 0x05, lsb: 0x10), dataEntryMSB: 0x08, dataEntryLSB: nil)
        )
        #expect(event.channel == 2)
    }
    
    @Test
    func init_Event_init_midi1FileRawBytes_SinglePacket_RunningStatus_NoDataLSB() async throws {
        let bytes: [UInt8] = [
            0x4D, 0x54, 0x72, 0x6B, // MTrk
            0x00, 0x00, 0x00, 0x0E, // length: 14 bytes to follow
            
            0x00,                   // delta time
            0xB2, 0x63, 0x05,       // cc 99, chan 2
            0x00,                   // delta time
            0x62, 0x10,             // cc 98, chan 2, running status 0xB2
            0x00,                   // delta time
            0x06, 0x08,             // cc 6, chan 2, running status 0xB2
            
            0x00,                   // delta time prior to chunk end
            0xFF, 0x2F, 0x00        // chunk end
        ]
        
        // (not implemented, so we need to test parsing using a track instead)
        // let event = try MIDIFileEvent.NRPN(midi1FileRawBytes: bytes)
        
        let timebase: MusicalMIDI1File.Timebase = .musical(ticksPerQuarterNote: 960)
        
        let parsedTrackA = try #require(try MusicalMIDI1File.Track(
            midi1FileRawBytesStream: bytes,
            timebase: timebase,
            options: .init(bundleRPNAndNRPNEvents: true)
        ))
        #expect(parsedTrackA.events.count == 1)
        guard case let .nrpn(event) = parsedTrackA.events[0].event else { Issue.record(); return }
        let delta = parsedTrackA.events[0].delta
        
        #expect(delta.ticks(using: timebase) == 0)
        #expect(
            event.parameter ==
                .raw(parameter: .init(msb: 0x05, lsb: 0x10), dataEntryMSB: 0x08, dataEntryLSB: nil)
        )
        #expect(event.channel == 2)
    }
    
    @Test
    func event_MIDI1SMFRawBytes_SinglePacket_FullyFormedMessages_NoDataLSB() async {
        let event = MIDIFileEvent.NRPN(
            .raw(parameter: .init(msb: 0x05, lsb: 0x10), dataEntryMSB: 0x08, dataEntryLSB: nil),
            change: .absolute,
            channel: 2
        )
        
        // (first delta time is omitted as always, it synthesizes zero delta times for subsequent events)
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [
            0xB2, 0x63, 0x05, // cc 99, chan 2
            0x00,             // delta time
            0xB2, 0x62, 0x10, // cc 98, chan 2
            0x00,             // delta time
            0xB2, 0x06, 0x08  // cc 6, chan 2
        ])
    }
    
    /// Test parsing NRPN events when a prior running status is present.
    @Test
    func initFrom_priorRunningStatus() async throws {
        let ccEvent = MIDIEvent.CC(controller: 1, value: .midi1(0x14), channel: 2)
        let nrpnEvent = MIDIEvent.NRPN(
            .raw(parameter: .init(msb: 0x05, lsb: 0x10), dataEntryMSB: 0x08, dataEntryLSB: 0x07),
            channel: 2
        )
        
        let bytes: [UInt8] = [
            0x4D, 0x54, 0x72, 0x6B, // MTrk
            0x00, 0x00, 0x00, 0x14, // length: 20 bytes to follow
            
            0x00,                   // delta time
            0xB2, 0x01, 0x14,       // cc event, sets running status byte
            
            0x01,                   // delta time
            0x63, 0x05,             // cc 99, chan 1, running status 0xB1
            0x02,                   // delta time
            0x62, 0x10,             // cc 98, chan 1, running status 0xB1
            0x03,                   // delta time
            0x06, 0x08,             // cc 6, chan 1, running status 0xB1
            0x04,                   // delta time
            0x26, 0x07,             // cc 38, chan 1, running status 0xB1
            
            0x00,                   // delta time prior to chunk end
            0xFF, 0x2F, 0x00        // chunk end
        ]
        
        // parse raw bytes
        
        let timebase: MusicalMIDI1File.Timebase = .musical(ticksPerQuarterNote: 960)
        let rpnTotalTicks: UInt32 = 0x01 + 0x02 + 0x03 + 0x04
        
        let parsedTrackA = try #require(try MusicalMIDI1File.Track(
            midi1FileRawBytesStream: bytes,
            timebase: timebase,
            options: .init(bundleRPNAndNRPNEvents: true)
        ))
        #expect(parsedTrackA.events.count == 2)
        #expect(parsedTrackA.events[0].delta == .none)
        #expect(parsedTrackA.events[0].event == .cc(ccEvent))
        #expect(parsedTrackA.events[1].delta == .ticks(rpnTotalTicks))
        #expect(parsedTrackA.events[1].event.midiEvent() == .nrpn(nrpnEvent))
        
        let parsedTrackB = try #require(try MusicalMIDI1File.Track(
            midi1FileRawBytes: bytes[8...], // exclude header and length
            timebase: timebase,
            options: .init(bundleRPNAndNRPNEvents: true)
        ))
        #expect(parsedTrackB.events.count == 2)
        #expect(parsedTrackB.events[0].delta == .none)
        #expect(parsedTrackB.events[0].event == .cc(ccEvent))
        #expect(parsedTrackB.events[1].delta == .ticks(rpnTotalTicks))
        #expect(parsedTrackB.events[1].event.midiEvent() == .nrpn(nrpnEvent))
    }
}
