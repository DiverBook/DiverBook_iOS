//
//  BadgeDetailView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import SwiftUI

struct BadgeDetailView: View {
    let badge: Badge

    var body: some View {
        VStack(alignment: .center) {
            if badge.isCollected {
                Image(badge.code)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 87, height: 124)
            } else {
                Image("lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }

            Text(badge.name)
                .font(DiveFont.headingH3)
                .foregroundStyle(DiveColor.color5)

            Spacer().frame(height: 12)

            Text(badge.description)
                .font(DiveFont.bodyMedium2)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(DiveColor.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

#Preview {
    BadgeDetailView(
        badge: Badge(
            code: "B002",
            name: "수면 돌파",
            description: "벌써 10명의 다이버를 만났어요.  \n수면 위의 세상이 눈 앞에!",
            imageName: "B001",
            isCollected: true
        )
    )
}
