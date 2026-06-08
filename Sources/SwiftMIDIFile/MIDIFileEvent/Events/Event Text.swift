//
//  Event Text.swift
//  SwiftMIDI File • https://github.com/orchetect/swift-midi-file
//  © 2026 Steffan Andrews • Licensed under MIT License
//

internal import SwiftDataParsing
import Foundation
import SwiftMIDICore

// MARK: - Text

// ------------------------------------
// NOTE: When revising these documentation blocks, they are duplicated in:
//   - MIDIFileEvent enum case (`case keySignature(_:)`, etc.)
//   - MIDIFileEvent concrete payload structs (`KeySignature`, etc.)
//   - DocC documentation for each MIDIFileEvent type
// ------------------------------------

extension MIDIFileEvent {
    /// Text event.
    /// Includes copyright, marker, cue point, track/sequence name, instrument name, generic text,
    /// program name, device name, or lyric.
    ///
    /// The Standard MIDI File 1.0 Spec specifies that for widest compatibility, text should consist of
    /// ASCII characters only. It allows for other text encodings, but it is up to each individual
    /// manufacturer to implement support for additional encodings such as UTF-8.
    ///
    /// That being said, any valid text encoding is supported by SwiftMIDI, but it is recommended to
    /// use ASCII.
    ///
    /// Logic Pro 12.2 supports UTF-8 when importing and exporting MIDI files. However, Cubase 14 and
    /// Pro Tools 2026.4 do not -- they will destructively force any non-ASCII bytes to ASCII.
    public struct Text {
        /// Type of text event.
        public var textType: EventType = .text

        /// Text content.
        ///
        /// The Standard MIDI File 1.0 Spec specifies that for widest compatibility, text should consist of
        /// ASCII characters only. It allows for other text encodings, but it is up to each individual
        /// manufacturer to implement support for additional encodings such as UTF-8.
        ///
        /// That being said, any valid text encoding is supported by SwiftMIDI, but it is recommended to
        /// use ASCII.
        ///
        /// Logic Pro 12.2 supports UTF-8 when importing and exporting MIDI files. However, Cubase 14 and
        /// Pro Tools 2026.4 do not -- they will destructively force any non-ASCII bytes to ASCII.
        ///
        /// (Arbitrary limit imposed: truncates at 65,536 characters long.)
        public var text: String = "" {
            didSet {
                validateText()
            }
        }

        private mutating func validateText() {
            if let newString = encodingMode.convert(string: text) {
                text = newString
            }
            // note that this checks character count and not actual byte length,
            // so non-ASCII strings could actually exceed this byte length
            if text.count > 65536 {
                text = String(text.prefix(65536))
            }
        }

        /// Encoding mode to use.
        public var encodingMode: EncodingMode {
            didSet {
                validateText()
            }
        }

        // MARK: - Init

        public init(encodingMode: EncodingMode = .strictASCII) {
            self.encodingMode = encodingMode
        }

        public init(
            type: EventType,
            string: String,
            encodingMode: EncodingMode = .strictASCII
        ) {
            textType = type
            text = string
            self.encodingMode = encodingMode
            
            validateText()
        }
        
        /// Internal: Init used by the event decoder to bypass text validation.
        init(
            unsafeType type: EventType,
            string: String,
            encodingMode: EncodingMode
        ) {
            textType = type
            text = string
            self.encodingMode = encodingMode
        }

        // MARK: - Init (types)

        /// Construct copyright text.
        public init(copyright: String, encodingMode: EncodingMode = .strictASCII) {
            self.init(type: .copyright, string: copyright, encodingMode: encodingMode)
        }

        /// Construct marker text.
        public init(marker: String, encodingMode: EncodingMode = .strictASCII) {
            self.init(type: .marker, string: marker, encodingMode: encodingMode)
        }

        /// Construct cue point text.
        public init(cuePoint: String, encodingMode: EncodingMode = .strictASCII) {
            self.init(type: .cuePoint, string: cuePoint, encodingMode: encodingMode)
        }

        /// Construct track or sequence name text.
        public init(trackOrSequenceName: String, encodingMode: EncodingMode = .strictASCII) {
            self.init(type: .trackOrSequenceName, string: trackOrSequenceName, encodingMode: encodingMode)
        }

        /// Construct instrument name text.
        public init(instrumentName: String, encodingMode: EncodingMode = .strictASCII) {
            self.init(type: .instrumentName, string: instrumentName, encodingMode: encodingMode)
        }

        /// Construct text.
        public init(text: String, encodingMode: EncodingMode = .strictASCII) {
            self.init(type: .text, string: text, encodingMode: encodingMode)
        }

        /// Construct program name text.
        public init(programName: String, encodingMode: EncodingMode = .strictASCII) {
            self.init(type: .programName, string: programName, encodingMode: encodingMode)
        }

        /// Construct device name text.
        public init(deviceName: String, encodingMode: EncodingMode = .strictASCII) {
            self.init(type: .deviceName, string: deviceName, encodingMode: encodingMode)
        }

        /// Construct lyric text.
        public init(lyric: String, encodingMode: EncodingMode = .strictASCII) {
            self.init(type: .lyric, string: lyric, encodingMode: encodingMode)
        }
    }
}

extension MIDIFileEvent.Text: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.textType == rhs.textType
            && lhs.text == rhs.text
        // do not include `encodingMode`
    }
}

extension MIDIFileEvent.Text: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(textType)
        hasher.combine(text)
        // do not include `encodingMode`
    }
}

extension MIDIFileEvent.Text: Sendable { }

// MARK: - Static Constructors

extension MIDIFileEvent {
    /// Text event.
    /// Includes copyright, marker, cue point, track/sequence name, instrument name, generic text,
    /// program name, device name, or lyric.
    public static func text(
        type: Text.EventType,
        string: String,
        encodingMode: Text.EncodingMode = .strictASCII
    ) -> Self {
        .text(
            .init(
                type: type,
                string: string,
                encodingMode: encodingMode
            )
        )
    }
}

extension MIDI1File.Track.Event {
    /// Text event.
    /// Includes copyright, marker, cue point, track/sequence name, instrument name, generic text,
    /// program name, device name, or lyric.
    public static func text(
        delta: DeltaTime = .none,
        type: MIDIFileEvent.Text.EventType,
        string: String,
        encodingMode: MIDIFileEvent.Text.EncodingMode = .strictASCII
    ) -> Self {
        let event: MIDIFileEvent = .text(
            type: type,
            string: string,
            encodingMode: encodingMode
        )
        return Self(delta: delta, event: event)
    }
}

// MARK: - Encoding

extension MIDIFileEvent.Text: MIDIFileEventPayload {
    public static var midiFileEventType: MIDIFileEventType {
        .text
    }

    public func asMIDIFileEvent() -> MIDIFileEvent {
        .text(self)
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
        let textType: EventType
        let text: String
        let encodingMode: EncodingMode
        let byteLength: Int
        do throws(MIDIFileDecodeError) {
            (textType, text, encodingMode, byteLength) = try stream.withDataParser { parser throws(MIDIFileDecodeError) in
                // 2-byte preambles
                let headerBytes = try parser.toMIDIFileDecodeError(
                    malformedReason: "Text is missing event header bytes.",
                    parser.read(bytes: 2)
                )
                guard let textTypeMatch = EventType(midi1FileRawBytes: headerBytes)
                else {
                    throw .malformed(
                        "Event is not a text event."
                    )
                }

                let length = try parser.midi1FileVariableLengthValue()

                let byteSlice = try parser.toMIDIFileDecodeError(
                    malformedReason: "Text does not have enough bytes.",
                    parser.read(bytes: length)
                )

                let string = EncodingMode.decode(rawStringBytes: byteSlice)
                
                let encodingMode = EncodingMode.mostRestrictiveMode(for: string)
                
                let byteLength = parser.readOffset

                return (
                    textType: textTypeMatch,
                    text: string,
                    encodingMode: encodingMode,
                    byteLength: byteLength
                )
            }
        } catch {
            return .unrecoverableError(error: error)
        }

        let newEvent = Self(unsafeType: textType, string: text, encodingMode: encodingMode)

        return .event(
            payload: newEvent,
            byteLength: byteLength
        )
    }

    public func midi1FileRawBytes<D: MutableDataProtocol>(as dataType: D.Type) -> D {
        // FF 01 length text

        let encodedData = encodingMode.encode(string: text, as: D.self)

        return textType.prefixBytes
            // length
            + D(midi1FileVariableLengthValue: encodedData.count)
            // text
            + encodedData
    }

    public var midiFileDescription: String {
        "\(textType): " + text.quoted
    }

    public var midiFileDebugDescription: String {
        "Text(" + midiFileDescription + ")"
    }
}

// MARK: - EventType

extension MIDIFileEvent.Text {
    /// Specialized text-based MIDI file track events.
    public enum EventType: String {
        // MARK: Track Events - First track

        // MARK: ... head of track

        /// Copyright text.
        /// If present, this event should only exist at the start of the first track.
        case copyright

        // MARK: ... anywhere in track

        /// Marker text event.
        /// If present, this event can appear anywhere within a track, but should only exist in the first track.
        case marker

        /// Cue point text event.
        /// If present, this event can appear anywhere within a track, but should only exist in the first track.
        case cuePoint

        // MARK: Track Events - Any track

        // MARK: ... head of track

        /// Track or sequence name text event.
        /// If present, this event can be used in one or more tracks, but should only exist at the start of each track.
        case trackOrSequenceName

        /// Instrument name text event.
        /// If present, this event can be used in one or more tracks, but should only exist at the start of each track.
        case instrumentName

        /// Generic text event.
        /// If present, this event can be used in one or more tracks, but should only exist at the start of each track.
        case text

        // MARK: ... anywhere in track

        /// Program name text event.
        /// This event can be used as often as desired anywhere within any track(s).
        case programName

        /// Device name text event.
        /// This event can be used as often as desired anywhere within any track(s).
        case deviceName

        /// Lyric text event.
        /// This event can be used as often as desired anywhere within any track(s).
        case lyric
    }
}

extension MIDIFileEvent.Text.EventType: Equatable { }

extension MIDIFileEvent.Text.EventType: Hashable { }

extension MIDIFileEvent.Text.EventType: CaseIterable { }

extension MIDIFileEvent.Text.EventType: Sendable { }

// MARK: - EventType init

extension MIDIFileEvent.Text.EventType {
    public init?(midi1FileRawBytes rawBytes: some DataProtocol) {
        guard let match = Self.allCases.first(where: {
            $0.prefixBytes.elementsEqual(rawBytes)
        }) else { return nil }
        self = match
    }
}

// MARK: - EventType Static

extension MIDIFileEvent.Text.EventType {
    /// The prefix bytes that define the start of the event.
    public var prefixBytes: [UInt8] {
        // swiftformat:disable consecutiveSpaces
        switch self {
        case .text:                [0xFF, 0x01]
        case .copyright:           [0xFF, 0x02]
        case .trackOrSequenceName: [0xFF, 0x03]
        case .instrumentName:      [0xFF, 0x04]
        case .lyric:               [0xFF, 0x05]
        case .marker:              [0xFF, 0x06]
        case .cuePoint:            [0xFF, 0x07]
        case .programName:         [0xFF, 0x08]
        case .deviceName:          [0xFF, 0x09]
        }
        // swiftformat:enable consecutiveSpaces
    }
}

// MARK: - EncodingMode

extension MIDIFileEvent.Text {
    /// MIDI file text encoding mode.
    public enum EncodingMode {
        /// Enforces strict ASCII text encoding.
        /// Any non-ASCII characters will be lossily converted to valid ASCII.
        /// This mode strictly adheres to the Standard MIDI File 1.0 spec.
        case strictASCII
        
        /// Allows "extended ASCII" characters, which essentially allows any string comprised
        /// of entirely 8-bit unicode scalars. This gives a permissive approach to allowing
        /// unusual single-byte characters (which some software manufacturers support).
        case lenientASCII
        
        /// Allows UTF-8 encoding.
        ///
        /// Note that some software manufacturers may not support reading UTF-8 encoding.
        case allowUTF8
    }
}

extension MIDIFileEvent.Text.EncodingMode: Equatable { }

extension MIDIFileEvent.Text.EncodingMode: Hashable { }

extension MIDIFileEvent.Text.EncodingMode: CaseIterable { }

extension MIDIFileEvent.Text.EncodingMode: Sendable { }

// MARK: - EncodingMode Methods

extension MIDIFileEvent.Text.EncodingMode {
    /// Returns `true` if the given character can be encoded using the text encoding mode.
    func contains(character: Character) -> Bool {
        switch self {
        case .strictASCII:
            return character.isPrintableASCII
        
        case .lenientASCII:
            guard character.unicodeScalars.count == 1 else { return false }
            guard let scalar = character.unicodeScalars.first else { return false }
            return CharacterSet.asciiFull.contains(scalar)
        
        case .allowUTF8:
            // any character can be represented in UTF-8
            return true
        }
    }
    
    /// Performs lossy conversion of string if necessary in order to conform it to the encoding
    /// mode. Returns `nil` if the string already conforms to the encoding mode.
    func convert(string: some StringProtocol) -> String? {
        switch self {
        case .strictASCII:
            let converted = string.convertToASCII()
            return converted != string ? converted : nil
        
        case .lenientASCII:
            let converted = string.convertToFullASCII()
            return converted != string ? converted : nil
        
        case .allowUTF8:
            // any string can be represented in UTF-8
            return nil
        }
    }
    
    /// Encodes the string to raw data bytes for encoding in a MIDI file text event.
    func encode<DataType: MutableDataProtocol>(string: some StringProtocol, as dataType: DataType.Type) -> DataType {
        switch self {
        case .strictASCII:
            DataType(string.map { $0.uInt8Value ?? 0x3F }) // `?` for potentially invalid chars
        case .lenientASCII:
            DataType(string.map { $0.uInt8Value ?? 0x3F }) // `?` for potentially invalid chars
        case .allowUTF8:
            if let data = string.data(using: .utf8) {
                DataType(data)
            } else {
                DataType(repeating: 0x3F, count: string.count) // `?` for potentially invalid chars
            }
        }
    }
    
    /// Decodes raw text bytes.
    static func decode(rawStringBytes: some DataProtocol) -> String {
        let data = Data(rawStringBytes)
        
        let string: String = if let text = String(data: data, encoding: .utf8) {
            text
        } else if let text = String(data: data, encoding: .nonLossyASCII) {
            text
        } else if let text = String(data: data, encoding: .ascii) {
            text
        } else if let text = String(data: data, encoding: .isoLatin1) {
            text
        } else {
            data.asciiDataToStringLossy()
        }
        
        return string
    }
    
    /// Returns the most restrictive encoding mode that the string complies with.
    static func mostRestrictiveMode(for string: some StringProtocol) -> Self {
        if Self.strictASCII.convert(string: string) == nil {
            .strictASCII
        } else if Self.lenientASCII.convert(string: string) == nil {
            .lenientASCII
        } else {
            .allowUTF8
        }
    }
}

// MARK: - String & Character Utilities

extension StringProtocol {
    /// Returns `true` if the string is entirely comprised of printable ASCII characters.
    var isPrintableASCII: Bool {
        allSatisfy(\.isPrintableASCII)
    }
    
    /// Returns `true` if the string is entirely comprised of 8-bit scalars.
    var is8Bit: Bool {
        allSatisfy(\.is8Bit)
    }
    
    /// Converts a string to full ASCII (8-bit scalars)
    func convertToFullASCII() -> String {
        var outputChars: [Character] = []
        for char in self {
            if char.is8Bit {
                outputChars.append(char)
            } else {
                let converted = "\(char)".convertToASCII()
                for convertedChar in converted {
                    if convertedChar.is8Bit {
                        outputChars.append(convertedChar)
                    } else {
                        outputChars.append("?")
                    }
                }
            }
        }
        return String(outputChars)
    }
}

extension Character {
    /// Returns `true` if the character is a printable ASCII character.
    var isPrintableASCII: Bool {
        guard unicodeScalars.count == 1 else { return false }
        guard let scalar = unicodeScalars.first else { return false }
        return CharacterSet.asciiPrintable.contains(scalar)
    }
    
    /// Returns `true` if the character is a single 8-bit scalar.
    var is8Bit: Bool {
        uInt8Value != nil
    }
    
    /// Returns the byte value if the character is a single 8-bit scalar.
    var uInt8Value: UInt8? {
        guard unicodeScalars.count == 1 else { return nil }
        guard let scalarValue = unicodeScalars.first?.value else { return nil }
        // This is the full 8-bit value range, same as `CharacterSet.fullASCII`
        guard (0x00 ... 0xFF).contains(scalarValue) else { return nil }
        let byte = UInt8(scalarValue) // guaranteed to succeed because of prior guard check
        return byte
    }
}
