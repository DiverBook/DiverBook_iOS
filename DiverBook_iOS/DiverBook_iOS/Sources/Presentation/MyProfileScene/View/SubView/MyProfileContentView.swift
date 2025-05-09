//
//  MyProfileContentView.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation
import SwiftUI

struct MyProfileContentView: View {
    @Binding var myProfile: DiverProfile
    let badgeCount: Int
    let onCollectedBadgeTap: () -> Void

    var body: some View {
        VStack {
            VStack(spacing: 8) {
                PrimaryProfile(
                    imageURL: myProfile.profileImageUrl,
                    style: .mypage
                )

                Text(myProfile.userName)
                    .font(DiveFont.headingH3)

                Spacer().frame(height: 20)

                TodayTalkSectionView(
                    mode: .editable(
                        binding: $myProfile.about
                    )
                )
                .padding(.horizontal, 4)

                Spacer().frame(height: 40)

                ProfileDetailsInfoView(
                    division: .editable(
                        binding: $myProfile.divisions
                    ),
                    phoneNumber: .editable(
                        binding: $myProfile.phoneNumber
                    ),
                    interests: .editable(
                        binding: $myProfile.interests
                    ),
                    places: .editable(
                        binding: $myProfile.places
                    )
                )

                Spacer().frame(height: 14)

                CollectedBadgeButtonView(
                    badgeCount: badgeCount,
                    onCollectedBadgeTap: onCollectedBadgeTap
                )

                Spacer()
            }

        }
    }
}
