import CoreGraphics
import Foundation

public struct GlowEffectPhase: Equatable {
    public let originUnitPoint: CGPoint
    public let progress: Double

    public init(originUnitPoint: CGPoint, progress: Double) {
        self.originUnitPoint = originUnitPoint
        self.progress = progress
    }

    public static func phase(at date: Date, duration: TimeInterval) -> GlowEffectPhase {
        phase(
            elapsed: date.timeIntervalSinceReferenceDate,
            duration: duration
        )
    }

    public static func phase(elapsed: TimeInterval, duration: TimeInterval) -> GlowEffectPhase {
        let normalizedDuration = max(duration, 0.1)
        let normalizedElapsed = elapsed / normalizedDuration
        let fraction = normalizedElapsed - floor(normalizedElapsed)
        let angle = fraction * .pi * 2

        return GlowEffectPhase(
            originUnitPoint: CGPoint(
                x: 0.5 + 0.5 * cos(angle),
                y: 0.5 + 0.5 * sin(angle)
            ),
            progress: 0.18 + 0.82 * sin(.pi * fraction)
        )
    }
}
