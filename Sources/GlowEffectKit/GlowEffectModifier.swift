import SwiftUI

public struct GlowEffectModifier: ViewModifier {
    public let isActive: Bool
    public let configuration: GlowEffectConfiguration

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isPulsing = false

    public init(
        isActive: Bool,
        configuration: GlowEffectConfiguration = GlowEffectConfiguration()
    ) {
        self.isActive = isActive
        self.configuration = configuration
    }

    public func body(content: Content) -> some View {
        content
            .overlay {
                glowOverlay
            }
            .scaleEffect(isPulsing ? configuration.peakScale : 1)
            .animation(animation, value: isPulsing)
            .onAppear {
                updatePulse()
            }
            .onChange(of: isActive) { _, _ in
                updatePulse()
            }
            .onChange(of: reduceMotion) { _, _ in
                updatePulse()
            }
    }

    private var shouldPulse: Bool {
        isActive && !reduceMotion
    }

    private var glowOverlay: some View {
        Group {
            if isActive {
                if reduceMotion {
                    glowingBorder(
                        originUnitPoint: CGPoint(x: 0.5, y: 0.5),
                        progress: 1
                    )
                } else {
                    TimelineView(.animation(minimumInterval: configuration.minimumTimelineInterval)) { timeline in
                        let phase = GlowEffectPhase.phase(
                            at: timeline.date,
                            duration: configuration.duration
                        )

                        glowingBorder(
                            originUnitPoint: phase.originUnitPoint,
                            progress: phase.progress
                        )
                    }
                }
            }
        }
        .allowsHitTesting(false)
    }

    private var gradientStops: [Gradient.Stop] {
        let colors = configuration.effectiveGlowColors

        guard colors.count > 1 else {
            return [.init(color: colors.first ?? .accentColor, location: 0)]
        }

        return colors.enumerated().map { offset, color in
            .init(color: color, location: Double(offset) / Double(colors.count - 1))
        }
    }

    private var animation: Animation {
        shouldPulse
            ? .easeInOut(duration: configuration.duration).repeatForever(autoreverses: true)
            : .smooth(duration: 0.18)
    }

    private var glowGradient: AngularGradient {
        AngularGradient(
            stops: gradientStops,
            center: .center,
            startAngle: .radians(.zero),
            endAngle: .radians(.pi * 2)
        )
    }

    private func glowingBorder(originUnitPoint: CGPoint, progress: Double) -> some View {
        RoundedRectangle(cornerRadius: configuration.cornerRadius, style: .continuous)
            .glowStroke(fill: glowGradient, lineWidth: configuration.lineWidth)
            .modifier(
                ProgressiveGlowEffect(
                    originUnitPoint: originUnitPoint,
                    progress: progress,
                    amplitude: configuration.amplitude
                )
            )
            .opacity(max(configuration.glowOpacity, 0.72))
            .compositingGroup()
    }

    private func updatePulse() {
        isPulsing = shouldPulse
    }
}

private struct ProgressiveGlowEffect: ViewModifier {
    let originUnitPoint: CGPoint
    let progress: Double
    let amplitude: Double

    func body(content: Content) -> some View {
        content.visualEffect { view, proxy in
            view.colorEffect(
                ShaderLibrary.bundle(.module).glowEffect(
                    .float2(
                        CGPoint(
                            x: originUnitPoint.x * proxy.size.width,
                            y: originUnitPoint.y * proxy.size.height
                        )
                    ),
                    .float2(proxy.size),
                    .float(amplitude),
                    .float(progress)
                )
            )
        }
    }
}

private extension Shape {
    func glowStroke(
        fill: some ShapeStyle,
        lineWidth: CGFloat,
        blurRadius: CGFloat = 8
    ) -> some View {
        stroke(style: StrokeStyle(lineWidth: lineWidth / 2, lineCap: .round))
            .fill(fill)
            .overlay {
                stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .fill(fill)
                    .blur(radius: blurRadius)
            }
            .overlay {
                stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .fill(fill)
                    .blur(radius: blurRadius / 2)
            }
    }
}

public extension View {
    func glowEffect(
        isActive: Bool,
        peakScale: CGFloat = 1.035,
        duration: TimeInterval = 1.6,
        glowOpacity: Double = 0.22,
        glowColors: [Color] = GlowEffectConfiguration.defaultGlowColors,
        cornerRadius: CGFloat = 34,
        lineWidth: CGFloat = 4
    ) -> some View {
        modifier(
            GlowEffectModifier(
                isActive: isActive,
                configuration: GlowEffectConfiguration(
                    peakScale: peakScale,
                    duration: duration,
                    glowOpacity: glowOpacity,
                    glowColors: glowColors,
                    cornerRadius: cornerRadius,
                    lineWidth: lineWidth
                )
            )
        )
    }

    func glowEffect(
        isActive: Bool,
        configuration: GlowEffectConfiguration
    ) -> some View {
        modifier(
            GlowEffectModifier(
                isActive: isActive,
                configuration: configuration
            )
        )
    }
}
