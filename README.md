# GlowEffectKit

<p align="center">
  <img src="https://pub-81dc0daed73f4a358469301b9b80f493.r2.dev/apps/gloweffectkit/app-icon.png" alt="GlowEffectKit logo" width="128">
</p>

SwiftUI package that provides an animated glow effect backed by a bundled Metal shader.

## Preview

![GlowEffectKit preview](./Resources/preview.gif)

## Requirements

- iOS 18.0+
- macOS 15.0+
- Swift 6.0+

## Installation

Add the package with Swift Package Manager:

```text
https://github.com/didisouzacosta/GlowEffectKit.git
```

If you prefer SSH, use the repository remote:

```text
git@github.com:didisouzacosta/GlowEffectKit.git
```

In Xcode, choose **File > Add Package Dependencies...**, paste the repository URL, and add the `GlowEffectKit` library product to your app target.

During local DressMatch development, this package can still be linked from a local checkout. For shared or CI builds, prefer the GitHub package URL above.

## Usage

```swift
import GlowEffectKit
import SwiftUI

Button("Generate") {}
    .glowEffect(
        isActive: true,
        peakScale: 1.025,
        duration: 1.45,
        glowOpacity: 0.28
    )
```

Use `GlowEffectConfiguration` when the caller needs to tune shader amplitude or frame interval:

```swift
let configuration = GlowEffectConfiguration(
    peakScale: 1.02,
    duration: 2.0,
    glowOpacity: 0.24,
    amplitude: 2.5,
    minimumTimelineInterval: 1.0 / 30.0
)

content.glowEffect(isActive: isLoading, configuration: configuration)
```

## License

GlowEffectKit is available under the MIT license. See `LICENSE` for details.
