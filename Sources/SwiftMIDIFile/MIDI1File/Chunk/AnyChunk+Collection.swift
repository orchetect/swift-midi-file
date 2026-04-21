//
//  AnyChunk+Collection.swift
//  swift-midi • https://github.com/orchetect/swift-midi
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftMIDICore
internal import SwiftMIDIInternals

// MARK: - Sequence Methods

extension Sequence {
    public typealias LazyTracksSequence<Timebase: MIDIFileTimebase> = LazyMapSequence<
        LazyFilterSequence<LazyMapSequence<Self, MIDI1File<Timebase>.Track?>>,
        MIDI1File<Timebase>.Track
    >
    
    /// Lazily returns tracks contained in the sequence.
    public func tracks<Timebase: MIDIFileTimebase>() -> LazyTracksSequence<Timebase>
    where Element == MIDI1File<Timebase>.AnyChunk {
        lazy.compactMap { (anyChunk) -> MIDI1File<Timebase>.Track? in
            guard case let .track(track) = anyChunk else { return nil }
            return track
        }
    }
}

// MARK: - Collection Methods

extension Collection where Self: RangeReplaceableCollection, Index == Int {
    /// Returns all indices of tracks contained in the sequence.
    public func trackIndices<Timebase: MIDIFileTimebase>() -> IndexSet
    where Element == MIDI1File<Timebase>.AnyChunk {
        let f = indices.filter { self[$0].isTrack }
        return IndexSet(f)
    }
}
