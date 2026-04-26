//
//  ChunkDecodeBlock.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension MIDI1File {
    /// MIDI file chunk decode result block.
    public typealias ChunkDecodeBlock = @Sendable (
        _ fileHeader: Header,
        _ chunkIndex: Int,
        _ chunkCount: Int,
        _ result: Result<AnyChunk, MIDIFileDecodeError>
    ) -> Void
}
