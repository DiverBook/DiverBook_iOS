//
//  ProfileView.swift
//  DiverBook_iOS
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct DiverProfileView: View {
    @State private var todayTalk: String = ""
    @State private var history: String = ""

    private var division = "디자인"
    private var phoneNumber = "010-0000-0000"
    private var interests = "사진, 아마스빈"
    private var places = "C5"

    var body: some View {
        ScrollView {
            VStack(spacing: 26) {
                DiverProfileHeaderSectionView(name: "Chloe", foundDate: "25.03.24")
                TodayTalkSectionView(mode: .readOnly(text: todayTalk))
                ProfileDetailsInfoView(
                    division: division,
                    phoneNumber: phoneNumber,
                    interests: interests,
                    places: places
                )
                Spacer().frame(height: 12)
                DiverHistorySectionView(history: $history)
                
                PrimaryButton(
                    title: "저장",
                    color: .lighter,
                    coordinator: Coordinator(),
                    action: {
                        // 저장 액션 처리
                    }
                )
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    DiverProfileView()
}
