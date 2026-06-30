import CoreGraphics
import Foundation
import SwiftUI

public struct GlowEffectConfiguration {
    public static let defaultGlowColors: [Color] = [
        .blue,
        .purple,
        .red,
        .mint,
        .indigo,
        .pink,
        .blue
    ]

    public var peakScale: CGFloat
    public var duration: TimeInterval
    public var glowOpacity: Double
    public var glowColors: [Color]
    public var cornerRadius: CGFloat
    public var lineWidth: CGFloat
    public var amplitude: Double
    public var minimumTimelineInterval: TimeInterval

    public var effectiveGlowColors: [Color] {
        glowColors.isEmpty ? Self.defaultGlowColors : glowColors
    }

    public init(
        peakScale: CGFloat = 1.035,
        duration: TimeInterval = 1.6,
        glowOpacity: Double = 0.22,
        glowColors: [Color] = Self.defaultGlowColors,
        cornerRadius: CGFloat = 34,
        lineWidth: CGFloat = 4,
        amplitude: Double = 3.0,
        minimumTimelineInterval: TimeInterval = 1.0 / 30.0
    ) {
        self.peakScale = peakScale
        self.duration = duration
        self.glowOpacity = glowOpacity
        self.glowColors = glowColors
        self.cornerRadius = cornerRadius
        self.lineWidth = lineWidth
        self.amplitude = amplitude
        self.minimumTimelineInterval = minimumTimelineInterval
    }
}
