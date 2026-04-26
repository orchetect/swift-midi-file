//
//  Parser FileDescriptor.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

extension MIDI1File.Parser {
    struct FileDescriptor {
        var header: MIDI1File.Header
        var chunkDescriptors: [ChunkDescriptor]
    }
}

extension MIDI1File.Parser.FileDescriptor: Equatable { }

extension MIDI1File.Parser.FileDescriptor: Hashable { }

extension MIDI1File.Parser.FileDescriptor: Sendable { }
