// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "GlowEffectKit",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "GlowEffectKit",
            targets: ["GlowEffectKit"]
        )
    ],
    targets: [
        .target(
            name: "GlowEffectKit",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "GlowEffectKitTests",
            dependencies: [
                "GlowEffectKit"
            ]
        )
    ]
)
