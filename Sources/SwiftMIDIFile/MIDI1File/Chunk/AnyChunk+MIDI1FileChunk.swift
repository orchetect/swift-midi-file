//
//  AnyChunk+MIDI1FileChunk.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension MIDI1File.AnyChunk: MIDI1FileChunk {
    public var identifier: MIDI1FileChunkIdentifier {
        switch self {
        case let .track(track): track.identifier
        case let .undefined(chunk): chunk.identifier
        }
    }
    
    public func isEqual(to other: Self) -> Bool {
        switch (self, other) {
        case let (.track(lhs), .track(rhs)): lhs.isEqual(to: rhs)
        case let (.undefined(lhs), .undefined(rhs)): lhs.isEqual(to: rhs)
        default: false
        }
    }
}
