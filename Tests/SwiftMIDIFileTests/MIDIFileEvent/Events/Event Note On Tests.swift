//
//  Event Note On Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

@testable import SwiftMIDIFile
import Testing

@Suite struct Event_NoteOn_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    @Test
    func init_midi1FileRawBytes_A() throws {
        let bytes: [UInt8] = [0x90, 0x01, 0x40]
        
        let event = try MIDIFileEvent.NoteOn(midi1FileRawBytes: bytes)
        
        #expect(event.note.number == 1)
        #expect(event.velocity == .midi1(0x40))
        #expect(event.channel == 0)
    }
    
    @Test
    func midi1FileRawBytes_A() {
        let event = MIDIFileEvent.NoteOn(
            note: 1,
            velocity: .midi1(0x40),
            channel: 0
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0x90, 0x01, 0x40])
    }
    
    @Test
    func init_midi1FileRawBytes_B() throws {
        let bytes: [UInt8] = [0x91, 0x3C, 0x7F]
        
        let event = try MIDIFileEvent.NoteOn(midi1FileRawBytes: bytes)
        
        #expect(event.note.number == 60)
        #expect(event.velocity == .midi1(0x7F))
        #expect(event.channel == 1)
    }
    
    @Test
    func midi1FileRawBytes_B() {
        let event = MIDIFileEvent.NoteOn(
            note: 60,
            velocity: .midi1(0x7F),
            channel: 1
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0x91, 0x3C, 0x7F])
    }
    
    // MARK: - Edge Cases
    
    @Test
    func init_midi1FileRawBytes_Velocity0() throws {
        let bytes: [UInt8] = [0x90, 0x3C, 0x00]
        
        let event = try MIDIFileEvent.NoteOn(midi1FileRawBytes: bytes)
        
        #expect(event.note.number == 60)
        #expect(event.velocity == .midi1(0x00))
        #expect(event.channel == 0)
    }
    
    @Test
    func midi1FileRawBytes_Velocity0_NoTranslation() {
        let event = MIDIFileEvent.NoteOn(
            note: 60,
            velocity: .midi1(0x00),
            channel: 0,
            midi1ZeroVelocityAsNoteOff: false
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0x90, 0x3C, 0x00])
    }
    
    @Test
    func midi1FileRawBytes_Velocity0_TranslateOff() {
        let event = MIDIFileEvent.NoteOn(
            note: 60,
            velocity: .midi1(0x00),
            channel: 0,
            midi1ZeroVelocityAsNoteOff: true
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0x80, 0x3C, 0x00]) // interpreted as Note Off
    }
    
    @Test
    func midi1FileRawBytes_Velocity1_TranslateOff() {
        let event = MIDIFileEvent.NoteOn(
            note: 60,
            velocity: .midi1(0x01),
            channel: 0,
            midi1ZeroVelocityAsNoteOff: true
        )
        
        let bytes: [UInt8] = event.midi1FileRawBytes(as: [UInt8].self)
        
        #expect(bytes == [0x90, 0x3C, 0x01])
    }
}
