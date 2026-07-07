import SwiftUI
import XCTest
@testable import GlowEffectKit

@MainActor
final class GlowEffectShapeAPITests: XCTestCase {
    func testGlowEffectAcceptsBuiltInShapes() {
        let circleView = Text("Circle")
            .glowEffect(isActive: true, shape: Circle(), lineWidth: 3)
        let capsuleView = Text("Capsule")
            .glowEffect(isActive: true, shape: Capsule(), lineWidth: 2)

        XCTAssertFalse(String(describing: type(of: circleView)).isEmpty)
        XCTAssertFalse(String(describing: type(of: capsuleView)).isEmpty)
    }

    func testGlowEffectAcceptsCustomShapeWithConfiguration() {
        let view = Text("Star")
            .glowEffect(
                isActive: true,
                shape: StarShape(),
                configuration: GlowEffectConfiguration(lineWidth: 5)
            )

        XCTAssertFalse(String(describing: type(of: view)).isEmpty)
    }
}

private struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.42

        var path = Path()

        for index in 0..<10 {
            let radius = index.isMultiple(of: 2) ? outerRadius : innerRadius
            let angle = CGFloat(index) * .pi / 5 - .pi / 2
            let point = CGPoint(
                x: center.x + radius * cos(angle),
                y: center.y + radius * sin(angle)
            )

            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }

        path.closeSubpath()

        return path
    }
}
