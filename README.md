# GrowEffectKit

SwiftUI package that provides an animated grow/glow effect backed by a bundled Metal shader.

## Installation

Add the package with Swift Package Manager:

```text
../GrowEffectKit
```

For the DressMatch app, this package is linked as a local Swift package from `DressMatch.xcodeproj`.

## Usage

```swift
import GrowEffectKit
import SwiftUI

Button("Generate") {}
    .growEffect(
        isActive: true,
        peakScale: 1.025,
        duration: 1.45,
        glowOpacity: 0.28
    )
```

Use `GrowEffectConfiguration` when the caller needs to tune shader amplitude or frame interval:

```swift
let configuration = GrowEffectConfiguration(
    peakScale: 1.02,
    duration: 2.0,
    glowOpacity: 0.24,
    amplitude: 2.5,
    minimumTimelineInterval: 1.0 / 30.0
)

content.growEffect(isActive: isLoading, configuration: configuration)
```
