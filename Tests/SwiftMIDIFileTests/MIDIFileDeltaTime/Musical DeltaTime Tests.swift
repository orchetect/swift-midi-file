//
//  Musical DeltaTime Tests.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation
import SwiftMIDIInternals
@testable import SwiftMIDIFile
import Testing

@Suite struct Musical_DeltaTime_Tests {
    // swiftformat:disable consecutiveSpaces
    // swiftformat:options --wrap-collections preserve --allow-partial-wrapping true
    
    /// Test the Musical timebase-specific static constructors on `DeltaTime`.
    @Test
    func musicalStaticConstructors_240ppq() async throws {
        typealias Delta = MusicalMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .musical(ticksPerQuarterNote: 240)
        
        // triplet == false (default)
        #expect(Delta.noteWhole.ticks(using: timebase) == 960)
        #expect(Delta.noteHalf.ticks(using: timebase) == 480)
        #expect(Delta.noteQuarter.ticks(using: timebase) == 240)
        #expect(Delta.note8th.ticks(using: timebase) == 120)
        #expect(Delta.note16th.ticks(using: timebase) == 60)
        #expect(Delta.note32nd.ticks(using: timebase) == 30)
        #expect(Delta.note64th.ticks(using: timebase) == 15)
        #expect(Delta.note128th.ticks(using: timebase) == 8) // note: 7.5 aliased (rounded)
        #expect(Delta.note256th.ticks(using: timebase) == 4) // note: 3.75 aliased (rounded)
        
        // triplet == true
        #expect(Delta.note8th(triplet: true).ticks(using: timebase) == 80)
        #expect(Delta.note16th(triplet: true).ticks(using: timebase) == 40)
        #expect(Delta.note32nd(triplet: true).ticks(using: timebase) == 20)
        #expect(Delta.note64th(triplet: true).ticks(using: timebase) == 10)
        #expect(Delta.note128th(triplet: true).ticks(using: timebase) == 5)
        #expect(Delta.note256th(triplet: true).ticks(using: timebase) == 3) // note: 2.5 aliased (rounded)
    }
    
    @Test
    func musicalStaticConstructors_480ppq() async throws {
        typealias Delta = MusicalMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .musical(ticksPerQuarterNote: 480)
        
        // triplet == false (default)
        #expect(Delta.noteWhole.ticks(using: timebase) == 1920)
        #expect(Delta.noteHalf.ticks(using: timebase) == 960)
        #expect(Delta.noteQuarter.ticks(using: timebase) == 480)
        #expect(Delta.note8th.ticks(using: timebase) == 240)
        #expect(Delta.note16th.ticks(using: timebase) == 120)
        #expect(Delta.note32nd.ticks(using: timebase) == 60)
        #expect(Delta.note64th.ticks(using: timebase) == 30)
        #expect(Delta.note128th.ticks(using: timebase) == 15)
        #expect(Delta.note256th.ticks(using: timebase) == 8) // note: 7.5 aliased (rounded)
        
        // triplet == true
        #expect(Delta.note8th(triplet: true).ticks(using: timebase) == 160)
        #expect(Delta.note16th(triplet: true).ticks(using: timebase) == 80)
        #expect(Delta.note32nd(triplet: true).ticks(using: timebase) == 40)
        #expect(Delta.note64th(triplet: true).ticks(using: timebase) == 20)
        #expect(Delta.note128th(triplet: true).ticks(using: timebase) == 10)
        #expect(Delta.note256th(triplet: true).ticks(using: timebase) == 5)
    }
    
    @Test
    func musicalStaticConstructors_960ppq() async throws {
        typealias Delta = MusicalMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .musical(ticksPerQuarterNote: 960)
        
        // triplet == false (default)
        #expect(Delta.noteWhole.ticks(using: timebase) == 3840)
        #expect(Delta.noteHalf.ticks(using: timebase) == 1920)
        #expect(Delta.noteQuarter.ticks(using: timebase) == 960)
        #expect(Delta.note8th.ticks(using: timebase) == 480)
        #expect(Delta.note16th.ticks(using: timebase) == 240)
        #expect(Delta.note32nd.ticks(using: timebase) == 120)
        #expect(Delta.note64th.ticks(using: timebase) == 60)
        #expect(Delta.note128th.ticks(using: timebase) == 30)
        #expect(Delta.note256th.ticks(using: timebase) == 15)
        
        // triplet == true
        #expect(Delta.note8th(triplet: true).ticks(using: timebase) == 320)
        #expect(Delta.note16th(triplet: true).ticks(using: timebase) == 160)
        #expect(Delta.note32nd(triplet: true).ticks(using: timebase) == 80)
        #expect(Delta.note64th(triplet: true).ticks(using: timebase) == 40)
        #expect(Delta.note128th(triplet: true).ticks(using: timebase) == 20)
        #expect(Delta.note256th(triplet: true).ticks(using: timebase) == 10)
    }
    
    @Test
    func musicalStaticConstructors_beats() async throws {
        typealias Delta = MusicalMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .musical(ticksPerQuarterNote: 480)
        
        #expect(Delta.beats(-1.0).ticks(using: timebase) == 0)
        #expect(Delta.beats(0.0).ticks(using: timebase) == 0)
        #expect(Delta.beats(0.25).ticks(using: timebase) == 120)
        #expect(Delta.beats(0.5).ticks(using: timebase) == 240)
        #expect(Delta.beats(1.0).ticks(using: timebase) == 480)
        #expect(Delta.beats(4.0).ticks(using: timebase) == 1920)
    }
    
    @Test
    func musicalStaticConstructors_edgeCases() async throws {
        typealias Delta = MusicalMIDI1File.Track.DeltaTime
        let timebase: Delta.Timebase = .default()
        
        #expect(Delta.ticks(UInt32.min).ticks(using: timebase) == UInt32.min)
        #expect(Delta.ticks(UInt32.max).ticks(using: timebase) == UInt32.max)
        
        #expect(Delta.noteWhole.ticks(using: .musical(ticksPerQuarterNote: 0)) == 0)
        #expect(Delta.noteWhole.ticks(using: .musical(ticksPerQuarterNote: 1)) == 4)
        #expect(Delta.noteWhole.ticks(using: .musical(ticksPerQuarterNote: UInt16.max)) == 4 * UInt32(UInt16.max))
        
        #expect(Delta.note256th.ticks(using: .musical(ticksPerQuarterNote: 0)) == 0)
        #expect(Delta.note256th.ticks(using: .musical(ticksPerQuarterNote: UInt16.max)) == 1024) // 1023.984375 rounded
    }
}
