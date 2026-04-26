//
//  MIDI1File init.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

internal import SwiftMIDIInternals
import Foundation
import SwiftMIDICore

// MARK: - Init: Raw Data

// see MIDI1File+Decoding.swift

// MARK: - Init: File Path

extension MIDI1File {
    /// Initialize by loading the contents of a MIDI file from disk.
    ///
    /// - Tip: Consider using the `async` overload of this initializer, as it is much more performant.
    public init(
        path: String,
        options: MIDI1FileDecodeOptions = MIDI1FileDecodeOptions(),
        predicate: DecodePredicate? = nil
    ) throws(MIDIFileDecodeError) {
        let url = try AnyMIDI1File.url(forFilePath: path)
        try self.init(url: url, options: options, predicate: predicate)
    }

    /// Initialize by loading the contents of a MIDI file from disk, parsing chunks concurrently for improved performance.
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    public init(
        path: String,
        options: MIDI1FileDecodeOptions = MIDI1FileDecodeOptions(),
        predicate: DecodePredicate? = nil
    ) async throws(MIDIFileDecodeError) {
        let url = try AnyMIDI1File.url(forFilePath: path)
        try await self.init(url: url, options: options, predicate: predicate)
    }

    /// Initialize by loading the contents of a MIDI file from disk, parsing chunks concurrently for improved performance.
    /// As each chunk completes parsing, a closure is called with the parsing results and the chunk's content.
    ///
    /// If the file header cannot be parsed or overall file structure is malformed, this method throws an error.
    /// Errors encountered during individual chunk parsing are returned within the result closure and not thrown from this method.
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    public init(
        path: String,
        options: MIDI1FileDecodeOptions = MIDI1FileDecodeOptions(),
        predicate: DecodePredicate? = nil,
        parsedChunk: @escaping ChunkDecodeBlock
    ) async throws(MIDIFileDecodeError) {
        let url = try AnyMIDI1File.url(forFilePath: path)
        try await self.init(url: url, options: options, predicate: predicate, parsedChunk: parsedChunk)
    }
}

// MARK: - Init: File URL

extension MIDI1File {
    /// Initialize by loading the contents of a MIDI file from disk.
    ///
    /// - Tip: Consider using the `async` overload of this initializer, as it is much more performant.
    public init(
        url: URL,
        options: MIDI1FileDecodeOptions = MIDI1FileDecodeOptions(),
        predicate: DecodePredicate? = nil
    ) throws(MIDIFileDecodeError) {
        let data = try AnyMIDI1File.data(forFileURL: url)
        try self.init(
            data: data,
            options: options,
            predicate: predicate
        )
    }

    /// Initialize by loading the contents of a MIDI file from disk, parsing chunks concurrently for improved performance.
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    public init(
        url: URL,
        options: MIDI1FileDecodeOptions = MIDI1FileDecodeOptions(),
        predicate: DecodePredicate? = nil
    ) async throws(MIDIFileDecodeError) {
        let data = try AnyMIDI1File.data(forFileURL: url)
        try await self.init(
            data: data,
            options: options,
            predicate: predicate
        )
    }

    /// Initialize by loading the contents of a MIDI file from disk, parsing chunks concurrently for improved performance.
    /// As each chunk completes parsing, a closure is called with the parsing results and the chunk's content.
    ///
    /// If the file header cannot be parsed or overall file structure is malformed, this method throws an error.
    /// Errors encountered during individual chunk parsing are returned within the result closure and not thrown from this method.
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    public init(
        url: URL,
        options: MIDI1FileDecodeOptions = MIDI1FileDecodeOptions(),
        predicate: DecodePredicate? = nil,
        parsedChunk: @escaping ChunkDecodeBlock
    ) async throws(MIDIFileDecodeError) {
        let data = try AnyMIDI1File.data(forFileURL: url)
        try await self.init(
            data: data,
            options: options,
            predicate: predicate,
            parsedChunk: parsedChunk
        )
    }
}
