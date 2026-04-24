# ``SwiftMIDIFile``

Standard MIDI File extension for SwiftMIDI.

![swift-midi-file](swift-midi-file-banner.png)

![Topology Diagram](swift-midi-topology.svg)

## Overview

This extension adds abstractions for reading and writing Standard MIDI Files.

Standard MIDI File 1.0 is supported, with support for the MIDI 2.0 version coming in a future update.

See <doc:Getting-Started> for a quick guide on getting the most out of SwiftMIDIFile.

Refer to SwiftMIDICore documentation for information on MIDI events.

## Topics

### Introduction

- <doc:Getting-Started>

### MIDI File Timebase

- ``MusicalMIDIFileTimebase``
- ``SMPTEMIDIFileTimebase``

### MIDI File Events

- ``MIDIFileEvent``
- ``MIDIFileEventType``

### MIDI File (SMF1)

- ``MIDI1File``
- ``MusicalMIDI1File``
- ``SMPTEMIDI1File``

### MIDI File Format (SMF1)

- ``MIDI1FileFormat``

### MIDI File Decoding (SMF1)

- ``MIDI1FileDecodeOptions``
- ``MIDI1FileChunkDecodeOptions``

### MIDI File Chunks (SMF1)

- ``MIDI1File/AnyChunk``
- ``MIDI1File/Track``
- ``MIDI1File/UndefinedChunk``

### MIDI File Track Chunk (SMF1)

- ``MIDI1File/Track/Event``
- ``MIDI1File/Track/DeltaTime``
- ``MusicalMIDIFileDeltaTime``
- ``SMPTEMIDIFileDeltaTime``

### Errors

- ``MIDIFileDecodeError``
- ``MIDIFileEncodeError``

### Related Types

- ``MusicalTimeValue``

### MIDI File Internals

- <doc:Internals>
