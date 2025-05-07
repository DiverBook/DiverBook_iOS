//
//  DiverProfileContentView.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation
import SwiftUI

struct DiverProfileContentView: View {
    let diverProfile: DiverProfile
    @Binding var history: String
    let isSaveEnabled: Bool
    let saveAction: () -> Void

    var body: some View {
        VStack(spacing: 26) {
            DiverProfileHeaderSectionView(
                profileImageURL: diverProfile.profileImageUrl,
                name: diverProfile.userName,
                //TODO: 서버에 발견일자 불러와야함, fetch 했을 때, foundDate 변수 없음
                foundDate: "25.03.04"
            )

            TodayTalkSectionView(
                mode: .readOnly(
                    text: diverProfile.about
                )
            )

            ProfileDetailsInfoView(
                division: .readOnly(
                    text: diverProfile.divisions
                ),
                phoneNumber: .readOnly(
                    text: diverProfile.phoneNumber
                ),
                interests: .readOnly(
                    text: diverProfile.interests
                ),
                places: .readOnly(
                    text: diverProfile.places
                )
            )

            Spacer().frame(height: 12)

            DiverHistorySectionView(history: $history)

            PrimaryButton(
                title: "저장",
                isEnabled: isSaveEnabled,
                color: .lighter,
                coordinator: Coordinator(),
                action: saveAction
            )
        }
    }
}
