//
//  UndefinedChunk+MIDI1FileChunkIdentifier.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

// MARK: - Static Constructor

extension MIDI1FileChunkIdentifier {
    /// Undefined (non-standard) chunk identifier.
    /// This identifier must be different from the header identifier (`MThd`) and the track identifier (`MTrk`).
    public static func undefined(identifier: String) -> MIDI1FileChunkIdentifier? {
        MIDI1FileChunkIdentifier(string: identifier)
    }
}
