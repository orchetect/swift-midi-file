//
//  MIDIEvent+MIDIFileEvent Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIFile
import Testing

@Suite struct MIDIEvent_to_MIDIFileEvent_Tests {
    @Test
    func midi_Event_NoteOn_midiFileEvent() throws {
        let event: MIDIEvent = .noteOn(
            60,
            velocity: .midi1(64),
            attribute: .profileSpecific(data: 0x1234),
            channel: 1,
            group: 2,
            midi1ZeroVelocityAsNoteOff: true
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // extract MIDIEvent payload
        guard case let .noteOn(unwrappedEvent) = event else {
            Issue.record(); return
        }
        
        // extract MIDIFileEvent payload
        guard case .noteOn(
            event: let unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }
        
        // compare payloads to ensure they are the same
        #expect(unwrappedEvent == unwrappedSMFEvent)
    }
    
    @Test
    func midi_Event_NoteOff_midiFileEvent() throws {
        let event: MIDIEvent = .noteOff(
            60,
            velocity: .midi1(0),
            attribute: .profileSpecific(data: 0x1234),
            channel: 1,
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // extract MIDIEvent payload
        guard case let .noteOff(unwrappedEvent) = event else {
            Issue.record(); return
        }
        
        // extract MIDIFileEvent payload
        guard case .noteOff(
            event: let unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }
        
        // compare payloads to ensure they are the same
        #expect(unwrappedEvent == unwrappedSMFEvent)
    }
    
    @Test
    func midi_Event_NoteCC_midiFileEvent() throws {
        let event: MIDIEvent = .noteCC(
            note: 60,
            controller: .registered(.modWheel),
            value: .midi2(32768),
            channel: 1,
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // no equivalent SMF event exists
        // (with the upcoming Standard MIDI File 2.0 spec, this may be implemented in future)
        #expect(midiFileEvent == nil)
    }
    
    @Test
    func midi_Event_NotePitchBend_midiFileEvent() throws {
        let event: MIDIEvent = .notePitchBend(
            note: 60,
            value: .midi2(.zero),
            channel: 1,
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // no equivalent SMF event exists
        // (with the upcoming Standard MIDI File 2.0 spec, this may be implemented in future)
        #expect(midiFileEvent == nil)
    }
    
    @Test
    func midi_Event_NotePressure_midiFileEvent() throws {
        let event: MIDIEvent = .notePressure(
            note: 60,
            amount: .midi2(.zero),
            channel: 1,
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // extract MIDIEvent payload
        guard case let .notePressure(unwrappedEvent) = event else {
            Issue.record(); return
        }
        
        // extract MIDIFileEvent payload
        guard case .notePressure(
            event: let unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }
        
        // compare payloads to ensure they are the same
        #expect(unwrappedEvent == unwrappedSMFEvent)
    }
    
    @Test
    func midi_Event_NoteManagement_midiFileEvent() throws {
        let event: MIDIEvent = .noteManagement(
            note: 60,
            flags: [.detachPerNoteControllers],
            channel: 1,
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // no equivalent SMF event exists
        // (with the upcoming Standard MIDI File 2.0 spec, this may be implemented in future)
        #expect(midiFileEvent == nil)
    }
    
    @Test
    func midi_Event_CC_midiFileEvent() throws {
        let event: MIDIEvent = .cc(
            .modWheel,
            value: .midi1(64),
            channel: 1,
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // extract MIDIEvent payload
        guard case let .cc(unwrappedEvent) = event else {
            Issue.record(); return
        }
        
        // extract MIDIFileEvent payload
        guard case .cc(
            event: let unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }
        
        // compare payloads to ensure they are the same
        #expect(unwrappedEvent == unwrappedSMFEvent)
    }
    
    @Test
    func midi_Event_ProgramChange_midiFileEvent() throws {
        let event: MIDIEvent = .programChange(
            program: 20,
            bank: .bankSelect(4),
            channel: 1,
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // extract MIDIEvent payload
        guard case let .programChange(unwrappedEvent) = event else {
            Issue.record(); return
        }
        
        // extract MIDIFileEvent payload
        guard case .programChange(
            event: let unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }
        
        // compare payloads to ensure they are the same
        #expect(unwrappedEvent == unwrappedSMFEvent)
    }
    
    @Test
    func midi_Event_RPN_midiFileEvent() throws {
        let event: MIDIEvent = .rpn(
            .channelFineTuning(123),
            channel: 0
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // extract MIDIEvent payload
        guard case let .rpn(unwrappedEvent) = event else {
            Issue.record(); return
        }
        
        // extract MIDIFileEvent payload
        guard case .rpn(
            event: let unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }
        
        // compare payloads to ensure they are the same
        #expect(unwrappedEvent == unwrappedSMFEvent)
    }
    
    @Test
    func midi_Event_NRPN_midiFileEvent() throws {
        let event: MIDIEvent = .nrpn(
            .raw(parameter: .init(msb: 2, lsb: 1), dataEntryMSB: 0x05, dataEntryLSB: 0x20),
            channel: 0
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // extract MIDIEvent payload
        guard case let .nrpn(unwrappedEvent) = event else {
            Issue.record(); return
        }
        
        // extract MIDIFileEvent payload
        guard case .nrpn(
            event: let unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }
        
        // compare payloads to ensure they are the same
        #expect(unwrappedEvent == unwrappedSMFEvent)
    }
    
    @Test
    func midi_Event_PitchBend_midiFileEvent() throws {
        let event: MIDIEvent = .pitchBend(
            value: .midi1(.midpoint),
            channel: 1,
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // extract MIDIEvent payload
        guard case let .pitchBend(unwrappedEvent) = event else {
            Issue.record(); return
        }
        
        // extract MIDIFileEvent payload
        guard case .pitchBend(
            event: let unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }
        
        // compare payloads to ensure they are the same
        #expect(unwrappedEvent == unwrappedSMFEvent)
    }
    
    @Test
    func midi_Event_Pressure_midiFileEvent() throws {
        let event: MIDIEvent = .pressure(
            amount: .midi1(5),
            channel: 1,
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // extract MIDIEvent payload
        guard case let .pressure(unwrappedEvent) = event else {
            Issue.record(); return
        }
        
        // extract MIDIFileEvent payload
        guard case .pressure(
            event: let unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }
        
        // compare payloads to ensure they are the same
        #expect(unwrappedEvent == unwrappedSMFEvent)
    }
    
    @Test
    func midi_Event_SysEx_midiFileEvent() throws {
        let event: MIDIEvent = try .sysEx7(
            manufacturer: .educational(),
            data: [0x12, 0x34],
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // extract MIDIEvent payload
        guard case let .sysEx7(unwrappedEvent) = event else {
            Issue.record(); return
        }
        
        // extract MIDIFileEvent payload
        guard case .sysEx7(
            event: let unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }
        
        // compare payloads to ensure they are the same
        #expect(unwrappedEvent == unwrappedSMFEvent)
    }
    
    @Test
    func midi_Event_UniversalSysEx_midiFileEvent() throws {
        let event: MIDIEvent = try .universalSysEx7(
            universalType: .nonRealTime,
            deviceID: 0x7F,
            subID1: 0x01,
            subID2: 0x02,
            data: [0x12, 0x34],
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // extract MIDIEvent payload
        guard case let .universalSysEx7(unwrappedEvent) = event else {
            Issue.record(); return
        }
        
        // extract MIDIFileEvent payload
        guard case .universalSysEx7(
            event: let unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }
        
        // compare payloads to ensure they are the same
        #expect(unwrappedEvent == unwrappedSMFEvent)
    }
    
    @Test
    func midi_Event_TimecodeQuarterFrame_midiFileEvent() {
        let event: MIDIEvent = .timecodeQuarterFrame(
            dataByte: 0x00,
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // not an event that can be stored in a MIDI file, only applicable to live MIDI I/O
        #expect(midiFileEvent == nil)
    }
    
    @Test
    func midi_Event_SongPositionPointer_midiFileEvent() {
        let event: MIDIEvent = .songPositionPointer(
            midiBeat: 8,
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // not an event that can be stored in a MIDI file, only applicable to live MIDI I/O
        #expect(midiFileEvent == nil)
    }
    
    @Test
    func midi_Event_SongSelect_midiFileEvent() {
        let event: MIDIEvent = .songSelect(
            number: 4,
            group: 2
        )
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // not an event that can be stored in a MIDI file, only applicable to live MIDI I/O
        #expect(midiFileEvent == nil)
    }
    
    @Test
    func midi_Event_TuneRequest_midiFileEvent() {
        let event: MIDIEvent = .tuneRequest(group: 2)
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // not an event that can be stored in a MIDI file, only applicable to live MIDI I/O
        #expect(midiFileEvent == nil)
    }
    
    @Test
    func midi_Event_TimingClock_midiFileEvent() {
        let event: MIDIEvent = .timingClock(group: 2)
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // not an event that can be stored in a MIDI file, only applicable to live MIDI I/O
        #expect(midiFileEvent == nil)
    }
    
    @Test
    func midi_Event_Start_midiFileEvent() {
        let event: MIDIEvent = .start(group: 2)
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // not an event that can be stored in a MIDI file, only applicable to live MIDI I/O
        #expect(midiFileEvent == nil)
    }
    
    @Test
    func midi_Event_Continue_midiFileEvent() {
        let event: MIDIEvent = .continue(group: 2)
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // not an event that can be stored in a MIDI file, only applicable to live MIDI I/O
        #expect(midiFileEvent == nil)
    }
    
    @Test
    func midi_Event_Stop_midiFileEvent() {
        let event: MIDIEvent = .stop(group: 2)
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // not an event that can be stored in a MIDI file, only applicable to live MIDI I/O
        #expect(midiFileEvent == nil)
    }
    
    @Test
    func midi_Event_ActiveSensing_midiFileEvent() {
        let event: MIDIEvent = .activeSensing(group: 2)
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // not an event that can be stored in a MIDI file, only applicable to live MIDI I/O
        #expect(midiFileEvent == nil)
    }
    
    @Test
    func midi_Event_SystemReset_midiFileEvent() {
        let event: MIDIEvent = .systemReset(group: 2)
        
        // convert MIDIEvent case to MIDIFileEvent case, preserving payloads
        let midiFileEvent = event.midiFileEvent()
        
        // not an event that can be stored in a MIDI file, only applicable to live MIDI I/O
        // (A system reset message byte (0xFF) is reserved in the MIDI file format as the start byte
        // for various MIDI file-specific event types.)
        #expect(midiFileEvent == nil)
    }
}
