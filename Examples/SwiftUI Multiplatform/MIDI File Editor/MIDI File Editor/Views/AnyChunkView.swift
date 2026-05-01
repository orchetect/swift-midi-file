//
//  AnyChunkView.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftMIDICore
import SwiftMIDIFile
import SwiftUI

struct AnyChunkView: View {
    @Binding var chunk: MusicalMIDI1File.AnyChunk

    var body: some View {
        switch chunk {
        case let .track(track):
            TrackView(track: Binding(get: { track }, set: { chunk = .track($0) }))
        case let .undefined(undefinedChunk):
            UndefinedChunkView(chunk: Binding(get: { undefinedChunk }, set: { chunk = .undefined($0) }))
        }
    }
}
