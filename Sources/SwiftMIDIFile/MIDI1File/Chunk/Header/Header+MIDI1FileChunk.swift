//
//  Header+MIDI1FileChunk.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension MIDI1File.Header: MIDI1FileChunk {
    public var identifier: MIDI1FileChunkIdentifier { Self.identifier }
    
    public static var identifier: MIDI1FileChunkIdentifier { .header }
    
    public func isEqual(to other: Self) -> Bool {
        // header does not conform to Identifiable or contain an `id` property
        self == other
    }
}
