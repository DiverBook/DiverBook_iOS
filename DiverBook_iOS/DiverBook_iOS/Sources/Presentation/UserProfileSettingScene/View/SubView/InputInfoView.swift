//
//  InputInfoView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/18/25.
//

import Combine
import SwiftUI

struct InputInfoView: View {
    var userInfoType: UserInfoType
    @Binding var inputText: String
    
    var body: some View {
        VStack(spacing: 0) {
            TextField(self.userInfoType.placeholder, text: self.$inputText)
                .keyboardType(self.userInfoType.keyboardType)
                .padding(.bottom, 6)
            Rectangle()
                .fill(DiveColor.gray2)
                .frame(height: 1)
        }
    }
}
