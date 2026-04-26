//
//  MusicalMIDI1File.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// MIDI file with musical timebase.
public typealias MusicalMIDI1File = MIDI1File<MusicalMIDIFileTimebase>

extension MusicalMIDI1File {
    /// Returns the first tempo event found in the MIDI file's tracks.
    ///
    /// > Note:
    /// >
    /// > If no tempo event is found, the Standard MIDI File 1.0 spec specifies that 120 bpm is the default that should be used.
    public var initialTempo: MIDIFileEvent.MusicalTempo? {
        for track in tracks {
            if let tempo = track.initialTempo {
                return tempo
            }
        }

        return nil
    }
}
