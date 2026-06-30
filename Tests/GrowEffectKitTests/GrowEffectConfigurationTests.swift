import CoreGraphics
import XCTest
@testable import GrowEffectKit

final class GrowEffectConfigurationTests: XCTestCase {
    func testDefaultConfigurationMatchesCurrentDressMatchBehavior() {
        let configuration = GrowEffectConfiguration()

        XCTAssertEqual(configuration.peakScale, CGFloat(1.035))
        XCTAssertEqual(configuration.duration, 1.6)
        XCTAssertEqual(configuration.glowOpacity, 0.22)
        XCTAssertEqual(configuration.cornerRadius, CGFloat(34))
        XCTAssertEqual(configuration.lineWidth, CGFloat(4))
        XCTAssertEqual(configuration.amplitude, 3.0)
        XCTAssertEqual(configuration.minimumTimelineInterval, 1.0 / 30.0)
        XCTAssertEqual(configuration.glowColors.count, 7)
    }

    func testEmptyColorInputFallsBackToDefaultGlowColors() {
        let configuration = GrowEffectConfiguration(glowColors: [])

        XCTAssertEqual(configuration.effectiveGlowColors.count, GrowEffectConfiguration.defaultGlowColors.count)
    }
}
