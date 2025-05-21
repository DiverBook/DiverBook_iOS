//
//  DiverProfileContentView.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation
import SwiftUI

struct DiverProfileContentView: View {
    @Binding var memo: String
    @FocusState var memoFocused: Bool
    let diverProfile: DiverProfile
    let foundDate: String
    let isSaveEnabled: Bool
    let saveAction: () -> Void

    var body: some View {
        VStack(spacing: 26) {
            DiverProfileHeaderSectionView(
                profileImageURL: diverProfile.profileImageUrl,
                name: diverProfile.userName,
                foundDate: foundDate
            )

            TodayTalkSectionView(
                mode: .readOnly(
                    text: diverProfile.about
                )
            )
            .padding(.top, -10)

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
            
            Divider()

            DiverHistorySectionView(history: $memo, memoFocused: _memoFocused)

            PrimaryButton(
                title: "저장",
                isEnabled: isSaveEnabled,
                color: .lighter,
                coordinator: Coordinator(),
                action: saveAction
            )
            .id("bottom")
        }
    }
}
