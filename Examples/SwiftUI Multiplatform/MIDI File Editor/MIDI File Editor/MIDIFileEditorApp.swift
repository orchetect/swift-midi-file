//
//  MIDIFileEditorApp.swift
//  SwiftMIDI Examples • https://github.com/orchetect/swift-midi-examples
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import SwiftUI

@main
struct MIDIFileEditorApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: MIDIFileDocument()) { config in
            MIDIFileView(document: config.$document)
        }
        #if os(macOS)
        .defaultSize(width: 900, height: 800)
        #endif
        .commands {
            SidebarCommands()
        }
    }
}
