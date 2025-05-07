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
            Image(badge.imageUrl)

            Text(badge.name)
                .font(DiveFont.headingH3)
                .foregroundStyle(DiveColor.color5)

            Spacer().frame(height: 12)

            Text(badge.description)
                .font(DiveFont.bodyMedium2)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    BadgeDetailView(
        badge: Badge(
            code: "B002",
            name: "수면 돌파",
            description: "벌써 10명의 다이버를 만났어요.  \n수면 위의 세상이 눈 앞에!",
            imageUrl: "badge2",
            isCollected: true
        )
    )
}
