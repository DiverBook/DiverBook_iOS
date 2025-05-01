//
//  SignUpPasswordInputView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/30/25.
//

import Combine
import SwiftUI

struct SignUpPasswordInputView: View {
    @ObservedObject var viewModel: UserProfileSettingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("정보 확인을 위한 비밀번호를\n생성해주세요.")
                .font(DiveFont.headingH2)
                .multilineTextAlignment(.leading)
                .padding(.top, 20)
                .padding(.bottom, 24)
            Text("비밀번호")
                .font(DiveFont.bodyMedium1)
                .foregroundStyle(DiveColor.gray4)
                .padding(.bottom, 10)
            Group {
                PasswordTextField(password: $viewModel.state.password)
                    .frame(height: 25)
                Rectangle()
                    .fill(DiveColor.gray2)
                    .frame(height: 1)
            }
            .frame(width: 250)
            .padding(.bottom, 5)
            Text("비밀번호는 숫자 네자리여야 합니다.")
                .font(DiveFont.bodyMedium2)
                .foregroundStyle(DiveColor.gray3)
            Spacer()
        }
    }
}
