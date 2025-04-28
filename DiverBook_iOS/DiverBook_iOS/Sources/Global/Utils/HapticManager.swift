//
//  HapticManager.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/27/25.
//

import CoreHaptics
import SwiftUI

final class HapticManager {
    static let instance = HapticManager()
    private var engine: CHHapticEngine?
    
    private init() {
        prepareHaptics()
    }
    
    // MARK: 기본 Haptic 효과들 (약함)
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: CoreHaptics 이용한 커스텀 햅틱
extension HapticManager {
    func cutstomStrongHaptic() {
        guard let engine = engine else { return }
        let events = [
            CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [
                    .init(parameterID: .hapticIntensity, value: 1.0),
                    .init(parameterID: .hapticSharpness, value: 0.8)
                ],
                relativeTime: 0.0
            ),
            CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [
                    .init(parameterID: .hapticIntensity, value: 1.0),
                    .init(parameterID: .hapticSharpness, value: 0.8)
                ],
                relativeTime: 0.2
            ),
            CHHapticEvent(
                eventType: .hapticContinuous,
                parameters: [
                    .init(parameterID: .hapticIntensity, value: 0.7),
                    .init(parameterID: .hapticSharpness, value: 0.3)
                ],
                relativeTime: 0.4,
                duration: 0.7
            )
        ]
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play haptic")
        }
    }
}
