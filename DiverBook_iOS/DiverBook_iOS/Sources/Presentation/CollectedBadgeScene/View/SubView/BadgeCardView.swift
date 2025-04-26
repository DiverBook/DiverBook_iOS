//
//  BadgeCardView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import SwiftUI

struct BadgeCardView: View {
    let badge: BadgeState
    @State private var isSheetPresented = false

    var body: some View {
        Button(action: {
            if badge.isCollected {
                isSheetPresented = true
            }
        }) {
            VStack(spacing: 8) {
                Image(badge.displayImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 62, height: 88)

                Text(badge.name)
                    .font(DiveFont.bodyMedium1)
                    .foregroundColor(
                        badge.isCollected ? DiveColor.black : DiveColor.gray3
                    )
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .background(DiveColor.white)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 2)
        }
        .sheet(isPresented: $isSheetPresented) {
            BadgeDetailView(badge: badge)
                .presentationDetents([.height(300)])
        }
    }
}

#Preview {
    BadgeCardView(
        badge: BadgeState(
            name: "첫 입수",
            displayImageName: "lock",
            isCollected: false,
            description: "첫 다이버를 등록했어요.\n당신의 탐험을 응원합니다!"
        )
    )
}
