//
//  BadgeCardView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import SwiftUI

struct BadgeCardView: View {
    let badge: BadgeState

    var body: some View {
        VStack(spacing: 8) {
            Image(badge.displayImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 62, height: 88)

            Text(badge.name)
                .font(DiveFont.bodyMedium1)
                .foregroundColor(badge.isCollected ? DiveColor.black : DiveColor.gray3)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(DiveColor.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    BadgeCardView(
        badge: BadgeState(
            name: "첫 입수",
            displayImageName: "lock",
            isCollected: true
        )
    )
}
