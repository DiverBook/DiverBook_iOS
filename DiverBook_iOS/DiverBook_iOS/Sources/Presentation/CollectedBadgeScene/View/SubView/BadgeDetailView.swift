//
//  BadgeDetailView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import SwiftUI

struct BadgeDetailView: View {
    let badge: BadgeMeta

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
            
            if badge.isCollected {
                Text(badge.description)
                    .font(DiveFont.bodyMedium2)
                    .multilineTextAlignment(.center)
            } else {
                Text(badge.condition)
                    .font(DiveFont.bodyMedium2)
                    .multilineTextAlignment(.center)
            }

        }
        .padding()
        .background(DiveColor.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

