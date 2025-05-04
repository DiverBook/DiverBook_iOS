//
//  LoginInputPaswordView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//
import SwiftUI

struct LoginInputPaswordView: View {
    @ObservedObject var viewModel: LoginViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("회원가입 시 등록한\n비밀번호를 입력해주세요.")
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
                    .onChange(of: viewModel.state.password) {
                        viewModel.action(.validatePassword)
                    }
                Rectangle()
                    .fill(DiveColor.gray2)
                    .frame(height: 1)
            }
            .frame(width: 300)
            .padding(.bottom, 5)
            Text("비밀번호는 숫자 네자리여야 합니다.")
                .font(DiveFont.bodyMedium2)
                .foregroundStyle(DiveColor.gray3)
            Spacer()
        }
    }
}
