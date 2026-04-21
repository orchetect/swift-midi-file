//
//  MIDIFileEvent+MIDIEvent.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDICore

extension MIDIFileEvent {
    /// Convert the SwiftMIDIFile event case (``MIDIFileEvent``) to a SwiftMIDICore event case (``SwiftMIDICore/MIDIEvent``).
    ///
    /// Not all MIDI File events translate to MIDI I/O events, in which case `nil` will be returned.
    public func midiEvent() -> MIDIEvent? {
        switch self {
        case let .cc(event):
            .cc(event)
            
        case let .noteOff(event):
            .noteOff(event)
            
        case let .noteOn(event):
            .noteOn(event)
            
        case let .notePressure(event):
            .notePressure(event)
            
        case let .pitchBend(event):
            .pitchBend(event)
            
        case let .pressure(event):
            .pressure(event)
            
        case let .programChange(event):
            .programChange(event)
            
        case let .sysEx7(event):
            .sysEx7(event)
            
        case let .universalSysEx7(event):
            .universalSysEx7(event)
            
        case let .rpn(event):
            .rpn(event)
            
        case let .nrpn(event):
            .nrpn(event)
            
        case .channelPrefix,
             .keySignature,
             .portPrefix,
             .sequenceNumber,
             .sequencerSpecific,
             .smpteOffset,
             .tempo,
             .text,
             .timeSignature,
             .unrecognizedMeta,
             .xmfPatchTypePrefix:
            // Not applicable to MIDI I/O, only applicable to MIDI files.
            nil
        }
    }
}
