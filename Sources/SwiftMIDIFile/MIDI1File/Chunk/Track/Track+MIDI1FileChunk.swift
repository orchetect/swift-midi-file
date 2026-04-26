//
//  Track+MIDI1FileChunk.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension MIDI1File.Track: MIDI1FileChunk {
    public var identifier: MIDI1FileChunkIdentifier {
        Self.identifier
    }

    public static var identifier: MIDI1FileChunkIdentifier {
        .track
    }

    public func isEqual(to other: Self) -> Bool {
        events.isEqual(to: other.events)
            && deltaTimeBeforeEndOfTrack == other.deltaTimeBeforeEndOfTrack
    }
}

// MARK: - AnyChunk Static Constructors

extension MIDI1File.AnyChunk {
    /// MIDI file track chunk identifier (`MTrk`).
    public static func track(_ events: [MIDI1File<Timebase>.Track.Event]) -> Self {
        .track(.init(events: events))
    }

    /// MIDI file track chunk identifier (`MTrk`).
    @_disfavoredOverload
    public static func track(_ events: some Sequence<MIDI1File<Timebase>.Track.Event>) -> Self {
        .track(.init(events: events))
    }
}
