//
//  MIDIEvent+MIDIFileEvent.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDICore

extension MIDIEvent {
    /// Convert the SwiftMIDICore event case (``MIDIEvent``) to a SwiftMIDIFile event case (``MIDIFileEvent``).
    ///
    /// Not all MIDI I/O events translate to MIDI File events, in which case `nil` will be returned.
    public func midiFileEvent() -> MIDIFileEvent? {
        switch self {
        case let .noteOn(event):
            .noteOn(event)
            
        case let .noteOff(event):
            .noteOff(event)
            
        case .noteCC:
            // TODO: MIDI 2.0 only (Official MIDI File 2.0 Spec is not yet finished)
            nil
            
        case .notePitchBend:
            // TODO: MIDI 2.0 only (Official MIDI File 2.0 Spec is not yet finished)
            nil
            
        case let .notePressure(event):
            .notePressure(event)
            
        case .noteManagement:
            // TODO: MIDI 2.0 only (Official MIDI File 2.0 Spec is not yet finished)
            nil
            
        case let .cc(event):
            .cc(event)
            
        case let .programChange(event):
            .programChange(event)
            
        case let .pitchBend(event):
            .pitchBend(event)
            
        case let .pressure(event):
            .pressure(event)
            
        case let .rpn(event):
            .rpn(event)
            
        case let .nrpn(event):
            .nrpn(event)
            
        case let .sysEx7(event):
            .sysEx7(event)
            
        case let .universalSysEx7(event):
            .universalSysEx7(event)
            
        case .sysEx8:
            // TODO: MIDI 2.0 only (Official MIDI File 2.0 Spec is not yet finished)
            nil
            
        case .universalSysEx8:
            // TODO: MIDI 2.0 only (Official MIDI File 2.0 Spec is not yet finished)
            nil
            
        case .timecodeQuarterFrame,
             .songPositionPointer,
             .songSelect,
             .tuneRequest,
             .timingClock,
             .start,
             .continue,
             .stop,
             .activeSensing,
             .systemReset:
            // Not applicable to MIDI files.
            nil
            
        case .noOp,
             .jrClock,
             .jrTimestamp:
            // MIDI 2.0 only, also not applicable to MIDI files.
            nil
        }
    }
}
