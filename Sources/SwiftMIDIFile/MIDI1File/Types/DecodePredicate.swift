//
//  DecodePredicate.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension MIDI1File {
    /// MIDI file decoding predicate.
    public typealias DecodePredicate = @Sendable (
        _ chunkIdentifier: MIDI1FileChunkIdentifier,
        _ chunkIndex: Int
    ) -> Bool
}
