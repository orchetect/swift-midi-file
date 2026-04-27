# Undefined Meta

Undefined Meta Event

@Comment {
    // ------------------------------------
    // NOTE: When revising these documentation blocks, they are duplicated in:
    //   - MIDIFileEvent enum case (`case keySignature(_:)`, etc.)
    //   - MIDIFileEvent concrete payload structs (`KeySignature`, etc.)
    //   - DocC documentation for each MIDIFileEvent type
    // ------------------------------------
}

> Note: When parsing MIDI files, this is a placeholder for unrecognized or potentially malformed data. It is not defined by the Standard MIDI spec, and is therefore not meant to be used when authoring or writing MIDI files.

> Standard MIDI File 1.0 Spec:
>
> All meta-events begin with `0xFF`, then have an event type byte (which is always less than 128), and then have the length of the data stored as a variable-length quantity, and then the data itself. If there is no data, the length is `0`. As with chunks, future meta-events may be designed which may not be known to existing programs, so programs must properly ignore meta-events which they do not recognize, and indeed, should expect to see them. Programs must never ignore the length of a meta-event which they do recognize, and they shouldn't be surprised if it's bigger than they expected. If so, they must ignore everything past what they know about. However, they must not add anything of their own to the end of a meta-event.
>
> SysEx events and meta-events cancel any running status which was in effect. Running status does not apply to and may not be used for these messages.

## Topics

### Constructors

- ``MIDIFileEvent/undefinedMeta(metaType:data:)``

### Switch Case Unwrapping

- ``MIDIFileEvent/undefinedMeta(_:)``
- ``MIDIFileEvent/UndefinedMeta``
