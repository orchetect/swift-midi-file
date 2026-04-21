//
//  Header+MIDI1FileChunkIdentifier.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

// MARK: - Static Constructor

extension MIDI1FileChunkIdentifier {
    /// MIDI file header chunk identifier (`MThd`).
    public static var header: MIDI1FileChunkIdentifier {
        .init(unsafe: "MThd")
    }
}
