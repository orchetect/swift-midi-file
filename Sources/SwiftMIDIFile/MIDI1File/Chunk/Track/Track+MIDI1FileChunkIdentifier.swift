//
//  Track+MIDI1FileChunkIdentifier.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

// MARK: - Static Constructor

extension MIDI1FileChunkIdentifier {
    /// MIDI file track chunk identifier (`MTrk`).
    public static var track: MIDI1FileChunkIdentifier {
        .init(unsafe: "MTrk")
    }
}
