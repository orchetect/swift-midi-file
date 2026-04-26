//
//  MIDI1FileChunk.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

/// Protocol defining a Standard MIDI File chunk.
public protocol MIDI1FileChunk: Equatable, Hashable, Sendable {
    /// MIDI file chunk identifier.
    var identifier: MIDI1FileChunkIdentifier { get }

    /// Returns `true` if the content of the chunk is equal to another chunk of the same type.
    /// (Omits `id` from the comparison.)
    func isEqual(to other: Self) -> Bool
}
