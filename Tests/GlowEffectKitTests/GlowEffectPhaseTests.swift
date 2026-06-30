import CoreGraphics
import XCTest
@testable import GlowEffectKit

final class GlowEffectPhaseTests: XCTestCase {
    func testPhaseStartsAtRightCenterWithMinimumProgress() {
        let phase = GlowEffectPhase.phase(
            elapsed: 0,
            duration: 2
        )

        XCTAssertEqual(phase.originUnitPoint.x, 1.0, accuracy: 0.0001)
        XCTAssertEqual(phase.originUnitPoint.y, 0.5, accuracy: 0.0001)
        XCTAssertEqual(phase.progress, 0.18, accuracy: 0.0001)
    }

    func testPhaseHalfwayMovesToLeftCenterWithPeakProgress() {
        let phase = GlowEffectPhase.phase(
            elapsed: 1,
            duration: 2
        )

        XCTAssertEqual(phase.originUnitPoint.x, 0.0, accuracy: 0.0001)
        XCTAssertEqual(phase.originUnitPoint.y, 0.5, accuracy: 0.0001)
        XCTAssertEqual(phase.progress, 1.0, accuracy: 0.0001)
    }

    func testDurationIsClampedToAvoidDivisionByZero() {
        let phase = GlowEffectPhase.phase(
            elapsed: 0.05,
            duration: 0
        )

        XCTAssertEqual(phase.originUnitPoint.x, 0.0, accuracy: 0.0001)
        XCTAssertEqual(phase.originUnitPoint.y, 0.5, accuracy: 0.0001)
        XCTAssertEqual(phase.progress, 1.0, accuracy: 0.0001)
    }
}
