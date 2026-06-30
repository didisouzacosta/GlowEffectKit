import CoreGraphics
import XCTest
@testable import GrowEffectKit

final class GrowEffectPhaseTests: XCTestCase {
    func testPhaseStartsAtRightCenterWithMinimumProgress() {
        let phase = GrowEffectPhase.phase(
            elapsed: 0,
            duration: 2
        )

        XCTAssertEqual(phase.originUnitPoint.x, 1.0, accuracy: 0.0001)
        XCTAssertEqual(phase.originUnitPoint.y, 0.5, accuracy: 0.0001)
        XCTAssertEqual(phase.progress, 0.18, accuracy: 0.0001)
    }

    func testPhaseHalfwayMovesToLeftCenterWithPeakProgress() {
        let phase = GrowEffectPhase.phase(
            elapsed: 1,
            duration: 2
        )

        XCTAssertEqual(phase.originUnitPoint.x, 0.0, accuracy: 0.0001)
        XCTAssertEqual(phase.originUnitPoint.y, 0.5, accuracy: 0.0001)
        XCTAssertEqual(phase.progress, 1.0, accuracy: 0.0001)
    }

    func testDurationIsClampedToAvoidDivisionByZero() {
        let phase = GrowEffectPhase.phase(
            elapsed: 0.05,
            duration: 0
        )

        XCTAssertEqual(phase.originUnitPoint.x, 0.0, accuracy: 0.0001)
        XCTAssertEqual(phase.originUnitPoint.y, 0.5, accuracy: 0.0001)
        XCTAssertEqual(phase.progress, 1.0, accuracy: 0.0001)
    }
}
