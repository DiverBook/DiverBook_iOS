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
                .onChange(of: self.viewModel.state.shortBio) {
                    
                }
            }
            if self.viewModel.state.profileSettingPhase.phaseStep > 4 {
                Spacer().frame(height: 38)
                Text("자주 가는 장소")
                Spacer().frame(height: 10)
                InputInfoView(
                    userInfoType: .preferredPlaces,
                    inputText: self.$viewModel.state.preferredPlaces)
            }
            if self.viewModel.state.profileSettingPhase.phaseStep > 3 {
                Spacer().frame(height: 38)
                Text("관심사")
                Spacer().frame(height: 10)
                InputInfoView(
                    userInfoType: .inserests,
                    inputText: self.$viewModel.state.interests)
            }
            if self.viewModel.state.profileSettingPhase.phaseStep > 2 {
                Spacer().frame(height: 38)
                Text("전화번호")
                Spacer().frame(height: 10)
                InputInfoView(
                    userInfoType: .phoneNumber,
                    inputText: self.$viewModel.state.phoneNumber)
            }
            if self.viewModel.state.profileSettingPhase.phaseStep > 1 {
                Spacer().frame(height: 38)
                Text("희망 분야")
                Spacer().frame(height: 10)
                SelectPreferredFieldView(
                    selectedPreferredField: self.$viewModel.state
                        .preferredField
                )
            }
        }
    }
}
