//
//  CheckDetectedIDCardInfoView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/18/25.
//

import SwiftUI

struct CheckDetectedIDCardInfoView: View {
    var nickname: String
    
    var body: some View {
        Text("촬영된 정보를 확인하세요.")
            .font(DiveFont.headingH2)
            .foregroundStyle(DiveColor.gray4)
            .padding(.bottom, 4)
        Text("정보가 다를 경우, 재촬영 버튼을 누르세요")
            .font(DiveFont.bodyMedium1)
            .foregroundStyle(DiveColor.gray4)
            .padding(.bottom, 64)
        InitialUserProfileView(nickname: self.nickname)
            .frame(width: UIScreen.main.bounds.width - 48)
    }
}
