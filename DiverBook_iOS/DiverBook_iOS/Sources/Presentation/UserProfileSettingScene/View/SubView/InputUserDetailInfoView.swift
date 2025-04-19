//
//  InputUserDetailInfoView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/18/25.
//

import Combine
import SwiftUI

struct InputUserDetailInfoView: View {

    @ObservedObject var viewModel: UserProfileSettingViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 32)

            if self.viewModel.state.profileSettingPhase.phaseStep > 5 {
                Text("한 줄 소개")
                Spacer().frame(height: 10)
                InputInfoView(
                    userInfoType: .shortBio,
                    inputText: self.$viewModel.state.shortBio)
            }
            if self.viewModel.state.profileSettingPhase.phaseStep > 4 {
                infoField(
                    title: "자주 가는 장소",
                    view: InputInfoView(
                        userInfoType: .preferredPlaces,
                        inputText: self.$viewModel.state.preferredPlaces
                    )
                )
            }
            if self.viewModel.state.profileSettingPhase.phaseStep > 3 {
                infoField(
                    title: "관심사",
                    view: InputInfoView(
                        userInfoType: .inserests,
                        inputText: self.$viewModel.state.interests
                    )
                )
            }
            if self.viewModel.state.profileSettingPhase.phaseStep > 2 {
                infoField(
                    title: "전화번호",
                    view: InputInfoView(
                        userInfoType: .phoneNumber,
                        inputText: self.$viewModel.state.phoneNumber
                    )
                )
            }
            if self.viewModel.state.profileSettingPhase.phaseStep > 1 {
                infoField(
                    title: "희망 분야",
                    view: SelectPreferredFieldView(
                        selectedPreferredField: self.$viewModel.state
                            .preferredField
                    )
                )
            }
        }
    }
    
    @ViewBuilder
    private func infoField(
        title: String,
        view: some View
    ) -> some View {
        Spacer().frame(height: 38)
        Text(title).font(DiveFont.bodyMedium1)
        Spacer().frame(height: 10)
        view
    }
}
