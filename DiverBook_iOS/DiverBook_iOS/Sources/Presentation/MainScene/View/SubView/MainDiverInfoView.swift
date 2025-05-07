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
            PrimaryProfile(imageURL: viewModel.state.myProfile.profileImageUrl, style: .basic)
                .padding(.trailing, 10)
            LearnerNicknameView(nickname: $viewModel.state.myProfile.userName)
            Spacer()
            ProfileSettingButton(profileSettingButtonTapAction: {
                self.viewModel.action(.profileSettingButtonTapped)
            })
        }
    }
}
