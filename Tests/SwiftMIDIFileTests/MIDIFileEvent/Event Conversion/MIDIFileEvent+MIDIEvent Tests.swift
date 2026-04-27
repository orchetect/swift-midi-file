//
//  MIDIFileEvent+MIDIEvent Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDIFile
import Testing

@Suite
struct MIDIFileEvent_to_MIDIEvent_Tests {
    @Test
    func midi_File_Event_CC_midiEvent() {
        let midiFileEvent = MIDIFileEvent.cc(
            controller: .modWheel,
            value: .midi1(64),
            channel: 1
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // extract MIDIFileEvent payload
        guard case let .cc(
            event: unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }

        // extract MIDIEvent payload
        guard case let .cc(unwrappedEvent) = event else {
            Issue.record(); return
        }

        // compare payloads to ensure they are the same
        #expect(unwrappedSMFEvent == unwrappedEvent)
    }

    @Test
    func midi_File_Event_NoteOff_midiEvent() {
        let midiFileEvent = MIDIFileEvent.noteOff(
            note: 60,
            velocity: .midi1(0),
            channel: 1
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // extract MIDIFileEvent payload
        guard case let .noteOff(
            event: unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }

        // extract MIDIEvent payload
        guard case let .noteOff(unwrappedEvent) = event else {
            Issue.record(); return
        }

        // compare payloads to ensure they are the same
        #expect(unwrappedSMFEvent == unwrappedEvent)
    }

    @Test
    func midi_File_Event_NoteOn_midiEvent() {
        let midiFileEvent = MIDIFileEvent.noteOn(
            note: 60,
            velocity: .midi1(64),
            channel: 1
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // extract MIDIFileEvent payload
        guard case let .noteOn(
            event: unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }

        // extract MIDIEvent payload
        guard case let .noteOn(unwrappedEvent) = event else {
            Issue.record(); return
        }

        // compare payloads to ensure they are the same
        #expect(unwrappedSMFEvent == unwrappedEvent)
    }

    @Test
    func midi_File_Event_NotePressure_midiEvent() {
        let midiFileEvent = MIDIFileEvent.notePressure(
            note: 60,
            amount: .midi1(64),
            channel: 1
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // extract MIDIFileEvent payload
        guard case let .notePressure(
            event: unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }

        // extract MIDIEvent payload
        guard case let .notePressure(unwrappedEvent) = event else {
            Issue.record(); return
        }

        // compare payloads to ensure they are the same
        #expect(unwrappedSMFEvent == unwrappedEvent)
    }

    @Test
    func midi_File_Event_PitchBend_midiEvent() {
        let midiFileEvent = MIDIFileEvent.pitchBend(
            value: .midi1(.midpoint),
            channel: 1
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // extract MIDIFileEvent payload
        guard case let .pitchBend(
            event: unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }

        // extract MIDIEvent payload
        guard case let .pitchBend(unwrappedEvent) = event else {
            Issue.record(); return
        }

        // compare payloads to ensure they are the same
        #expect(unwrappedSMFEvent == unwrappedEvent)
    }

    @Test
    func midi_File_Event_Pressure_midiEvent() {
        let midiFileEvent = MIDIFileEvent.pressure(
            amount: .midi1(.midpoint),
            channel: 1
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // extract MIDIFileEvent payload
        guard case let .pressure(
            event: unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }

        // extract MIDIEvent payload
        guard case let .pressure(unwrappedEvent) = event else {
            Issue.record(); return
        }

        // compare payloads to ensure they are the same
        #expect(unwrappedSMFEvent == unwrappedEvent)
    }

    @Test
    func midi_File_Event_ProgramChange_midiEvent() {
        let midiFileEvent = MIDIFileEvent.programChange(
            program: 20,
            channel: 1
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // extract MIDIFileEvent payload
        guard case let .programChange(
            event: unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }

        // extract MIDIEvent payload
        guard case let .programChange(unwrappedEvent) = event else {
            Issue.record(); return
        }

        // compare payloads to ensure they are the same
        #expect(unwrappedSMFEvent == unwrappedEvent)
    }

    @Test
    func midi_File_Event_RPN_midiEvent() {
        let midiFileEvent = MIDIFileEvent.rpn(
            parameter: .channelFineTuning(123),
            change: .absolute,
            channel: 0
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // extract MIDIFileEvent payload
        guard case let .rpn(
            event: unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }

        // extract MIDIEvent payload
        guard case let .rpn(unwrappedEvent) = event else {
            Issue.record(); return
        }

        // compare payloads to ensure they are the same
        #expect(unwrappedSMFEvent == unwrappedEvent)
    }

    @Test
    func midi_File_Event_NRPN_midiEvent() {
        let midiFileEvent = MIDIFileEvent.nrpn(
            parameter: .raw(
                parameter: .init(msb: 2, lsb: 1),
                dataEntryMSB: 0x05,
                dataEntryLSB: 0x20
            ),
            change: .absolute,
            channel: 0
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // extract MIDIFileEvent payload
        guard case let .nrpn(
            event: unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }

        // extract MIDIEvent payload
        guard case let .nrpn(unwrappedEvent) = event else {
            Issue.record(); return
        }

        // compare payloads to ensure they are the same
        #expect(unwrappedSMFEvent == unwrappedEvent)
    }

    @Test
    func midi_File_Event_SysEx7_midiEvent() throws {
        let midiFileEvent = try MIDIFileEvent.sysEx7(
            manufacturer: .educational(),
            data: [0x12, 0x34]
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // extract MIDIFileEvent payload
        guard case let .sysEx7(
            event: unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }

        // extract MIDIEvent payload
        guard case let .sysEx7(unwrappedEvent) = event else {
            Issue.record(); return
        }

        // compare payloads to ensure they are the same
        #expect(unwrappedSMFEvent == unwrappedEvent)
    }

    @Test
    func midi_File_Event_UniversalSysEx7_midiEvent() throws {
        let midiFileEvent = try MIDIFileEvent.universalSysEx7(
            universalType: .nonRealTime,
            deviceID: 0x7F,
            subID1: 0x01,
            subID2: 0x02,
            data: [0x12, 0x34]
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // extract MIDIFileEvent payload
        guard case let .universalSysEx7(
            event: unwrappedSMFEvent
        ) = midiFileEvent else {
            Issue.record(); return
        }

        // extract MIDIEvent payload
        guard case let .universalSysEx7(unwrappedEvent) = event else {
            Issue.record(); return
        }

        // compare payloads to ensure they are the same
        #expect(unwrappedSMFEvent == unwrappedEvent)
    }

    @Test
    func midi_File_Event_ChannelPrefix_midiEvent() {
        let midiFileEvent = MIDIFileEvent.channelPrefix(
            channel: 4
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // event has no MIDIEvent I/O event equivalent; applicable only to MIDI files
        #expect(event == nil)
    }

    @Test
    func midi_File_Event_KeySignature_midiEvent() {
        let midiFileEvent = MIDIFileEvent.keySignature(.aFlatMinor)

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // event has no MIDIEvent I/O event equivalent; applicable only to MIDI files
        #expect(event == nil)
    }

    @Test
    func midi_File_Event_PortPrefix_midiEvent() {
        let midiFileEvent = MIDIFileEvent.portPrefix(
            port: 4
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // event has no MIDIEvent I/O event equivalent; applicable only to MIDI files
        #expect(event == nil)
    }

    @Test
    func midi_File_Event_SequenceNumber_midiEvent() {
        let midiFileEvent = MIDIFileEvent.sequenceNumber(
            sequence: 4
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // event has no MIDIEvent I/O event equivalent; applicable only to MIDI files
        #expect(event == nil)
    }

    @Test
    func midi_File_Event_SequencerSpecific_midiEvent() {
        let midiFileEvent = MIDIFileEvent.sequencerSpecific(
            data: [0x12, 0x34]
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // event has no MIDIEvent I/O event equivalent; applicable only to MIDI files
        #expect(event == nil)
    }

    @Test
    func midi_File_Event_SMPTEOffset_midiEvent() {
        let midiFileEvent = MIDIFileEvent.smpteOffset(
            hr: 1,
            min: 2,
            sec: 3,
            fr: 4,
            subFr: 0,
            rate: .fps29_97d
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // event has no MIDIEvent I/O event equivalent; applicable only to MIDI files
        #expect(event == nil)
    }

    @Test
    func midi_File_Event_Tempo_midiEvent() {
        let midiFileEvent = MIDIFileEvent.tempo(
            bpm: 140.0
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // event has no MIDIEvent I/O event equivalent; applicable only to MIDI files
        #expect(event == nil)
    }

    @Test
    func midi_File_Event_Text_midiEvent() {
        let midiFileEvent = MIDIFileEvent.text(
            type: .trackOrSequenceName,
            string: "Piano"
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // event has no MIDIEvent I/O event equivalent; applicable only to MIDI files
        #expect(event == nil)
    }

    @Test
    func midi_File_Event_TimeSignature_midiEvent() {
        let midiFileEvent = MIDIFileEvent.timeSignature(
            numerator: 2,
            denominator: 2
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // event has no MIDIEvent I/O event equivalent; applicable only to MIDI files
        #expect(event == nil)
    }

    @Test
    func midi_File_Event_UnrecognizedMeta_midiEvent() {
        let midiFileEvent = MIDIFileEvent.unrecognizedMeta(
            metaType: 0x30,
            data: [0x12, 0x34]
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // event has no MIDIEvent I/O event equivalent; applicable only to MIDI files
        #expect(event == nil)
    }

    @Test
    func midi_File_Event_XMFPatchTypePrefix_midiEvent() {
        let midiFileEvent = MIDIFileEvent.xmfPatchTypePrefix(
            patchSet: .DLS
        )

        // convert MIDIFileEvent case to MIDIEvent case, preserving payloads
        let event = midiFileEvent.midiEvent()

        // event has no MIDIEvent I/O event equivalent; applicable only to MIDI files
        #expect(event == nil)
    }
}
