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
            Text(viewModel.state.profileSettingPhase.phaseNotifyString)
                .font(DiveFont.headingH2)
            
            Spacer().frame(height: 32)

            if self.viewModel.state.profileSettingPhase.phaseStep > 6 {
                Text("한 줄 소개")
                Spacer().frame(height: 10)
                InputInfoView(
                    userInfoType: .shortBio,
                    inputText: self.$viewModel.state.shortBio)
                .onChange(of: viewModel.state.shortBio) {
                    viewModel.action(.validateShortBio)
                }
            }
            if self.viewModel.state.profileSettingPhase.phaseStep > 5 {
                infoField(
                    title: "자주 가는 장소",
                    view: InputInfoView(
                        userInfoType: .preferredPlaces,
                        inputText: self.$viewModel.state.preferredPlaces
                    )
                )
                .onChange(of: viewModel.state.preferredPlaces) {
                    viewModel.action(.validatePreferredPlaces)
                }
            }
            if self.viewModel.state.profileSettingPhase.phaseStep > 4 {
                infoField(
                    title: "관심사",
                    view: InputInfoView(
                        userInfoType: .inserests,
                        inputText: self.$viewModel.state.interests
                    )
                )
                .onChange(of: viewModel.state.interests) {
                    viewModel.action(.validateInterests)
                }
            }
            if self.viewModel.state.profileSettingPhase.phaseStep > 3 {
                infoField(
                    title: "전화번호",
                    view: InputInfoView(
                        userInfoType: .phoneNumber,
                        inputText: self.$viewModel.state.phoneNumber
                    )
                )
                .onChange(of: viewModel.state.phoneNumber) {
                    viewModel.action(.validatePhoneNumber)
                }
            }
            if self.viewModel.state.profileSettingPhase.phaseStep > 2 {
                infoField(
                    title: "희망 분야",
                    view: SelectPreferredFieldView(
                        selectedPreferredField: self.$viewModel.state
                            .preferredField
                    )
                )
                .onChange(of: viewModel.state.preferredField) {
                    viewModel.action(.validatePreferredField)
                }
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
