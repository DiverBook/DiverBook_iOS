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
    @Binding var todayTalk: String
    @Binding var division: String
    @Binding var phoneNumber: String
    @Binding var interests: String
    @Binding var places: String
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

                TodayTalkSectionView(
                    mode: .editable(
                        binding: $todayTalk
                    )
                )
                .padding(.horizontal, 4)

                Spacer().frame(height: 40)

                ProfileDetailsInfoView(
                    division: .editable(binding: $division),
                    phoneNumber: .editable(binding: $phoneNumber),
                    interests: .editable(binding: $interests),
                    places: .editable(binding: $places)
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
