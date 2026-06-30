// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "GrowEffectKit",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "GrowEffectKit",
            targets: ["GrowEffectKit"]
        )
    ],
    targets: [
        .target(
            name: "GrowEffectKit",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "GrowEffectKitTests",
            dependencies: [
                "GrowEffectKit"
            ]
        )
    ]
)
