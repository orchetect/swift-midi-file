![swift-midi-file](Images/swift-midi-file-banner.png)

# SwiftMIDI File

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Forchetect%2Fswift-midi-file%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/orchetect/swift-midi-file) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Forchetect%2Fswift-midi-file%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/orchetect/swift-midi-file) [![License: MIT](http://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](https://github.com/orchetect/swift-midi-file/blob/main/LICENSE)

Extension for [SwiftMIDI](https://github.com/orchetect/swift-midi) adding support for reading and writing Standard MIDI Files.

## Compatibility

| macOS | iOS  | visionOS | Linux | Android | Windows |
| :---: | :--: | :------: | :---: | :-----: | :-----: |
|   🟢   |  🟢   |    🟢     |  🚧 †  |   🚧 †   |    -    |

`†` Support for indicated platforms is either planned or WIP.

## Getting Started

This extension is available as a Swift Package Manager (SPM) package.

To use this extension as standalone dependency (instead of importing the **swift-midi** umbrella repository):

1. Add the **swift-midi-file** repo as a dependency.

   ```swift
   .package(url: "https://github.com/orchetect/swift-midi-file", from: "1.0.0")
   ```

2. Add **SwiftMIDIFile** to your target.

   ```swift
   .product(name: "SwiftMIDIFile", package: "swift-midi-file")
   ```

3. Import **SwiftMIDIFile** to use it.

   ```swift
   import SwiftMIDIFile
   ```

## Documentation & Support

See the [online documentation](https://swiftpackageindex.com/orchetect/swift-midi-file/main/documentation) for this repository and its [Examples](Examples) folder.

For support, feature requests, and bug reports see the main [SwiftMIDI](https://github.com/orchetect/swift-midi) repository.

## Author

Coded by a bunch of 🐹 hamsters in a trenchcoat that calls itself [@orchetect](https://github.com/orchetect).

## License

Licensed under the MIT license. See [LICENSE](https://github.com/orchetect/swift-midi-file/blob/master/LICENSE) for details.
