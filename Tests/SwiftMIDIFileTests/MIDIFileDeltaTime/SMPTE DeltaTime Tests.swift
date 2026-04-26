//
//  SMPTE DeltaTime Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftMIDIInternals
@testable import SwiftMIDIFile
import Testing

@Suite struct SMPTE_DeltaTime_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    /// Test the SMPTE timebase-specific static constructors on `DeltaTime`.
    @Test
    func smpteStaticConstructors_fromSMPTEOffset_25fps_20tpf() async throws {
        typealias Delta = SMPTEMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .smpte(frameRate: .fps25, ticksPerFrame: 20)
        
        #expect(Delta.offset(MIDIFileEvent.SMPTEOffset(hr: 00, min: 00, sec: 00, fr: 00, rate: .fps25)).ticks(using: timebase) == 0)
        #expect(Delta.offset(MIDIFileEvent.SMPTEOffset(hr: 00, min: 01, sec: 20, fr: 10, rate: .fps25)).ticks(using: timebase) == 40_200)
        #expect(Delta.offset(MIDIFileEvent.SMPTEOffset(hr: 01, min: 01, sec: 20, fr: 10, rate: .fps25)).ticks(using: timebase) == 1_840_200)
    }
    
    @Test
    func smpteStaticConstructors_fromSMPTEOffset_25fps_40tpf() async throws {
        typealias Delta = SMPTEMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .smpte(frameRate: .fps25, ticksPerFrame: 40)
        
        #expect(Delta.offset(MIDIFileEvent.SMPTEOffset(hr: 00, min: 00, sec: 00, fr: 00, rate: .fps25)).ticks(using: timebase) == 0)
        #expect(Delta.offset(MIDIFileEvent.SMPTEOffset(hr: 00, min: 01, sec: 20, fr: 10, rate: .fps25)).ticks(using: timebase) == 80_400)
        #expect(Delta.offset(MIDIFileEvent.SMPTEOffset(hr: 01, min: 01, sec: 20, fr: 10, rate: .fps25)).ticks(using: timebase) == 3_680_400)
    }
    
    @Test
    func smpteStaticConstructors_frames_25fps_20tpf() async throws {
        typealias Delta = SMPTEMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .smpte(frameRate: .fps25, ticksPerFrame: 20)
        
        #expect(Delta.frames(0).ticks(using: timebase) == 0)
        #expect(Delta.frames(0.5).ticks(using: timebase) == 10)
        #expect(Delta.frames(1).ticks(using: timebase) == 20)
        #expect(Delta.frames(25).ticks(using: timebase) == 500)
        #expect(Delta.frames(50).ticks(using: timebase) == 1000)
    }
    
    @Test
    func smpteStaticConstructors_frames_25fps_40tpf() async throws {
        typealias Delta = SMPTEMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .smpte(frameRate: .fps25, ticksPerFrame: 40)
        
        #expect(Delta.frames(0).ticks(using: timebase) == 0)
        #expect(Delta.frames(0.5).ticks(using: timebase) == 20)
        #expect(Delta.frames(1).ticks(using: timebase) == 40)
        #expect(Delta.frames(25).ticks(using: timebase) == 1000)
        #expect(Delta.frames(50).ticks(using: timebase) == 2000)
    }
    
    @Test
    func smpteStaticConstructors_offset_25fps_20tpf() async throws {
        typealias Delta = SMPTEMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .smpte(frameRate: .fps25, ticksPerFrame: 20)
        
        #expect(Delta.offset(hr: 00, min: 00, sec: 00, fr: 00, rate: .fps25).ticks(using: timebase) == 0)
        #expect(Delta.offset(hr: 00, min: 01, sec: 20, fr: 10, rate: .fps25).ticks(using: timebase) == 40_200)
        #expect(Delta.offset(hr: 01, min: 01, sec: 20, fr: 10, rate: .fps25).ticks(using: timebase) == 1_840_200)
    }
    
    @Test
    func smpteStaticConstructors_offset_25fps_40tpf() async throws {
        typealias Delta = SMPTEMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .smpte(frameRate: .fps25, ticksPerFrame: 40)
        
        #expect(Delta.offset(hr: 00, min: 00, sec: 00, fr: 00, rate: .fps25).ticks(using: timebase) == 0)
        #expect(Delta.offset(hr: 00, min: 01, sec: 20, fr: 10, rate: .fps25).ticks(using: timebase) == 80_400)
        #expect(Delta.offset(hr: 01, min: 01, sec: 20, fr: 10, rate: .fps25).ticks(using: timebase) == 3_680_400)
    }
    
    @Test
    func smpteStaticConstructors_offset_edgeCases_25fps_0tpf() async throws {
        typealias Delta = SMPTEMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .smpte(frameRate: .fps25, ticksPerFrame: 0)
        
        #expect(Delta.offset(hr: 00, min: 00, sec: 00, fr: 00, rate: .fps25).ticks(using: timebase) == 0)
        #expect(Delta.offset(hr: 00, min: 01, sec: 20, fr: 10, rate: .fps25).ticks(using: timebase) == 0)
        #expect(Delta.offset(hr: 01, min: 01, sec: 20, fr: 10, rate: .fps25).ticks(using: timebase) == 0)
    }
    
    @Test
    func smpteStaticConstructors_offset_edgeCases_25fps_1tpf() async throws {
        typealias Delta = SMPTEMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .smpte(frameRate: .fps25, ticksPerFrame: 1)
        
        #expect(Delta.offset(hr: 00, min: 00, sec: 00, fr: 00, rate: .fps25).ticks(using: timebase) == 0)
        #expect(Delta.offset(hr: 00, min: 01, sec: 20, fr: 10, rate: .fps25).ticks(using: timebase) == 2010)
        #expect(Delta.offset(hr: 01, min: 01, sec: 20, fr: 10, rate: .fps25).ticks(using: timebase) == 92_010)
    }
    
    @Test
    func smpteStaticConstructors_offset_edgeCases_25fps_255tpf() async throws {
        typealias Delta = SMPTEMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .smpte(frameRate: .fps25, ticksPerFrame: UInt8.max)
        
        #expect(Delta.offset(hr: 00, min: 00, sec: 00, fr: 00, rate: .fps25).ticks(using: timebase) == 0)
        #expect(Delta.offset(hr: 00, min: 01, sec: 20, fr: 10, rate: .fps25).ticks(using: timebase) == 512_550)
        #expect(Delta.offset(hr: 01, min: 01, sec: 20, fr: 10, rate: .fps25).ticks(using: timebase) == 23_462_550)
    }
}
