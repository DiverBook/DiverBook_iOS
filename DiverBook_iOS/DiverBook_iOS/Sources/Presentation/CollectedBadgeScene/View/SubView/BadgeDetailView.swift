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
            if let url = URL(string: badge.imageUrl), badge.isCollected {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 87, height: 124)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 87, height: 124)
                    case .failure:
                        EmptyView()
                    @unknown default:
                        EmptyView()
                    }
                }
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
            imageUrl: "https://diverbook.sijun.dev/api/images/view/B007.png",
            isCollected: true
        )
    )
}
