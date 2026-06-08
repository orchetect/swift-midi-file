# Text

Text event.

@Comment {
    // ------------------------------------
    // NOTE: When revising these documentation blocks, they are duplicated in:
    //   - MIDIFileEvent enum case (`case keySignature(_:)`, etc.)
    //   - MIDIFileEvent concrete payload structs (`KeySignature`, etc.)
    //   - DocC documentation for each MIDIFileEvent type
    // ------------------------------------
}

Includes copyright, marker, cue point, track/sequence name, instrument name, generic text, program name, device name, or lyric.

## Text Encoding

The Standard MIDI File 1.0 Spec specifies that for widest compatibility, text should consist of printable ASCII characters only.
It allows for other text encodings, but it is up to each individual manufacturer to implement support for additional encodings such as UTF-8.

That being said, any valid text encoding is supported by SwiftMIDI, but it is recommended to use ASCII.

By way of example, Logic Pro 12.2 supports UTF-8 when importing and exporting MIDI files.
However, Cubase 14 and Pro Tools 2026.4 do not — they will force ASCII decoding which may corrupt the text.

## Topics

### Constructors

- ``MIDIFileEvent/text(type:string:encoding:)``

### Switch Case Unwrapping

- ``MIDIFileEvent/text(_:)``
- ``MIDIFileEvent/Text``

### Text Encoding

- ``MIDIFileEvent/Text/Encoding``
