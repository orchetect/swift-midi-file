//
//  MIDI1FileChunk+Collection.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension Collection where Element: MIDI1FileChunk {
    /// Returns `true` if the content of the chunk collection is equal to another chunk collection.
    /// (Omits `id` properties from the comparison.)
    public func isEqual(to other: some Collection<Element>) -> Bool {
        guard count == other.count else { return false }

        for (lhs, rhs) in zip(self, other) {
            guard lhs.isEqual(to: rhs) else { return false }
        }
        return true
    }
}
