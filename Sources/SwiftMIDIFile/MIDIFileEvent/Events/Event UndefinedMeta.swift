//
//  Event UndefinedMeta.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

internal import SwiftDataParsing
import Foundation
import SwiftMIDICore

// MARK: - UndefinedMeta

// ------------------------------------
// NOTE: When revising these documentation blocks, they are duplicated in:
//   - MIDIFileEvent enum case (`case keySignature(_:)`, etc.)
//   - MIDIFileEvent concrete payload structs (`KeySignature`, etc.)
//   - DocC documentation for each MIDIFileEvent type
// ------------------------------------

extension MIDIFileEvent {
    /// Undefined Meta Event
    ///
    /// > Note: When parsing MIDI files, this is a placeholder for unrecognized or potentially malformed
    /// > data. It is not defined by the Standard MIDI spec, and is therefore not meant to be used
    /// > when authoring or writing MIDI files.
    ///
    /// > Standard MIDI File 1.0 Spec:
    /// >
    /// > All meta-events begin with `0xFF`, then have an event type byte (which is always less than
    /// > 128), and then have the length of the data stored as a variable-length quantity, and then
    /// > the data itself. If there is no data, the length is `0`. As with chunks, future
    /// > meta-events may be designed which may not be known to existing programs, so programs must
    /// > properly ignore meta-events which they do not recognize, and indeed, should expect to see
    /// > them.
    /// >
    /// > Programs must never ignore the length of a meta-event which they do recognize, and they
    /// > shouldn't be surprised if it's bigger than they expected. If so, they must ignore
    /// > everything past what they know about. However, they must not add anything of their own to
    /// > the end of a meta-event.
    /// >
    /// > SysEx events and meta-events cancel any running status which was in effect. Running status
    /// > does not apply to and may not be used for these messages.
    public struct UndefinedMeta {
        // 0x00 is a known meta type, but just default to it here any way
        public var metaType: UInt8 = 0x00

        /// Data bytes.
        /// Typically begins with a 1 or 3 byte manufacturer ID, similar to SysEx.
        public var data: [UInt8] = []

        // MARK: - Init

        public init(
            metaType: UInt8,
            data: [UInt8]
        ) {
            self.metaType = metaType
            self.data = data
        }
    }
}

extension MIDIFileEvent.UndefinedMeta: Equatable { }

extension MIDIFileEvent.UndefinedMeta: Hashable { }

extension MIDIFileEvent.UndefinedMeta: Sendable { }

// MARK: - Static Constructors

extension MIDIFileEvent {
    /// Undefined Meta Event
    ///
    /// > Note: When parsing MIDI files, this is a placeholder for unrecognized or potentially malformed
    /// > data. It is not defined by the Standard MIDI spec, and is therefore not meant to be used
    /// > when authoring or writing MIDI files.
    ///
    /// > Standard MIDI File 1.0 Spec:
    /// >
    /// > All meta-events begin with `0xFF`, then have an event type byte (which is always less than
    /// > 128), and then have the length of the data stored as a variable-length quantity, and then
    /// > the data itself. If there is no data, the length is `0`. As with chunks, future
    /// > meta-events may be designed which may not be known to existing programs, so programs must
    /// > properly ignore meta-events which they do not recognize, and indeed, should expect to see
    /// > them.
    /// >
    /// > Programs must never ignore the length of a meta-event which they do recognize, and they
    /// > shouldn't be surprised if it's bigger than they expected. If so, they must ignore
    /// > everything past what they know about. However, they must not add anything of their own to
    /// > the end of a meta-event.
    /// >
    /// > SysEx events and meta-events cancel any running status which was in effect. Running status
    /// > does not apply to and may not be used for these messages.
    public static func undefinedMeta(
        metaType: UInt8,
        data: [UInt8]
    ) -> Self {
        .undefinedMeta(
            .init(
                metaType: metaType,
                data: data
            )
        )
    }
}

extension MIDI1File.Track.Event {
    /// Undefined Meta Event
    ///
    /// > Note: When parsing MIDI files, this is a placeholder for unrecognized or potentially malformed
    /// > data. It is not defined by the Standard MIDI spec, and is therefore not meant to be used
    /// > when authoring or writing MIDI files.
    ///
    /// > Standard MIDI File 1.0 Spec:
    /// >
    /// > All meta-events begin with `0xFF`, then have an event type byte (which is always less than
    /// > 128), and then have the length of the data stored as a variable-length quantity, and then
    /// > the data itself. If there is no data, the length is `0`. As with chunks, future
    /// > meta-events may be designed which may not be known to existing programs, so programs must
    /// > properly ignore meta-events which they do not recognize, and indeed, should expect to see
    /// > them.
    /// >
    /// > Programs must never ignore the length of a meta-event which they do recognize, and they
    /// > shouldn't be surprised if it's bigger than they expected. If so, they must ignore
    /// > everything past what they know about. However, they must not add anything of their own to
    /// > the end of a meta-event.
    /// >
    /// > SysEx events and meta-events cancel any running status which was in effect. Running status
    /// > does not apply to and may not be used for these messages.
    public static func undefinedMeta(
        delta: DeltaTime = .none,
        metaType: UInt8,
        data: [UInt8]
    ) -> Self {
        let event: MIDIFileEvent = .undefinedMeta(
            metaType: metaType,
            data: data
        )
        return Self(delta: delta, event: event)
    }
}

// MARK: - Encoding

extension MIDIFileEvent.UndefinedMeta: MIDIFileEventPayload {
    public static var midiFileEventType: MIDIFileEventType {
        .undefinedMeta
    }

    public func asMIDIFileEvent() -> MIDIFileEvent {
        .undefinedMeta(self)
    }

    public static func decode(
        midi1FileRawBytesStream stream: some DataProtocol,
        runningStatus: UInt8?
    ) -> MIDIFileEventDecodeResult<Self> {
        // Step 1: Check required byte count
        do throws(MIDIFileDecodeError) {
            _ = try requiredStreamByteLength(
                availableByteCount: stream.count,
                isRunningStatusPresent: runningStatus != nil
            )
        } catch {
            return .unrecoverableError(error: error)
        }

        // Step 2: Parse out required bytes
        let metaType: UInt8
        let data: [UInt8]
        let byteLength: Int
        do throws(MIDIFileDecodeError) {
            (metaType, data, byteLength) = try stream.withDataParser { parser throws(MIDIFileDecodeError) in
                // meta event byte
                guard (try? parser.readByte()) == 0xFF else {
                    throw .malformed(
                        "Meta event does not start with expected bytes."
                    )
                }

                let readMetaType = try parser.toMIDIFileDecodeError(
                    malformedReason: "Meta type byte is missing.",
                    parser.readByte()
                )

                let length = try parser.midi1FileVariableLengthValue()

                let readData = try parser.toMIDIFileDecodeError(
                    malformedReason: "Meta event does not have enough data bytes.",
                    parser.read(bytes: length)
                )

                let byteLength = parser.readOffset

                return (
                    metaType: readMetaType,
                    data: readData.toUInt8Bytes(),
                    byteLength: byteLength
                )
            }
        } catch {
            return .unrecoverableError(error: error)
        }

        let newEvent = Self(metaType: metaType, data: data)

        return .event(
            payload: newEvent,
            byteLength: byteLength
        )
    }

    public func midi1FileRawBytes<D: MutableDataProtocol>(as dataType: D.Type) -> D {
        // FF <type> <length> <bytes>
        // type == UInt8 meta type (unrecognized)

        [0xFF, metaType]
            // length of data
            + D(midi1FileVariableLengthValue: data.count)
            // data
            + data
    }

    public var midiFileDescription: String {
        "meta: \(metaType), \(data.count) bytes"
    }

    public var midiFileDebugDescription: String {
        let byteDump = data
            .hexString(padEachTo: 2, prefixes: true, separator: ", ")

        return "UndefinedMeta(type: \(metaType), \(data.count) bytes: [\(byteDump)]"
    }
}
