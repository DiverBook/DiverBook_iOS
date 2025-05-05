//
//  MainDiverInfoView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/23/25.
//

import Combine
import SwiftUI

struct MainDiverInfoView: View {
    @ObservedObject var viewModel: MainViewModel
    var body: some View {
        HStack(spacing: 0) {
            PrimaryProfile(imageURL: DiverProfile.mockData.profileImageUrl, style: .basic)
                .padding(.trailing, 10)
            LearnerNicknameView(nickname: self.$viewModel.state.userNickname)
            Spacer()
            ProfileSettingButton(profileSettingButtonTapAction: {
                self.viewModel.action(.profileSettingButtonTapped)
            })
        }
    }
}
