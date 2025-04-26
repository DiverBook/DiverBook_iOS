//
//  ProfileSettingButton.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/23/25.
//

import Combine
import SwiftUI

struct ProfileSettingButton: View {
    var profileSettingButtonTapAction: () -> Void
    
    init(profileSettingButtonTapAction: @escaping () -> Void) {
        self.profileSettingButtonTapAction = profileSettingButtonTapAction
    }
    
    var body: some View {
        VStack {
            Spacer().frame(height: 15)
            Text("프로필 관리")
                .font(DiveFont.bodyExtra1)
                .padding(.all, 5)
                .foregroundStyle(DiveColor.color2)
                .background(
                    Capsule()
                        .fill(.clear)
                        .stroke(
                            DiveColor.color2,
                            lineWidth: 1
                        )
                )
            Spacer()
        }
        .onTapGesture {
            self.profileSettingButtonTapAction()
        }
    }
}
