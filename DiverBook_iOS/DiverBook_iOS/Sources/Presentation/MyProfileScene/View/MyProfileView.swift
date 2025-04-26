//
//  MyProfileView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import SwiftUI

struct MyProfileView: View {
    @State private var todayTalk: String = "공기는 눈에 보이지 않지만 어디에나 있습니다."
    private var division = "디자인"
    private var phoneNumber = "010-0000-0000"
    private var interests = "사진, 아마스빈"
    private var places = "C5"

    var body: some View {
        VStack(spacing: 34) {
            VStack(spacing: 8) {
                PrimaryProfile(image: Image("exMemoji"), style: .mypage)

                Text("Air")
                    .font(DiveFont.headingH3)
            }

            TodayTalkSectionView(todayTalk: $todayTalk)

            ProfileDetailsInfoView(
                division: division,
                phoneNumber: phoneNumber,
                interests: interests,
                places: places
            )
            CollectedBadgeButtonView(badgeCount: 5)
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    MyProfileView()
}
