//
//  LearnerNicknameView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/23/25.
//

import Combine
import SwiftUI

struct LearnerNicknameView: View {
    @Binding var nickname: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(self.nickname)
                .font(DiveFont.headingH1)
                .foregroundStyle(.white)
            Text("Learner")
                .font(DiveFont.bodyMedium1)
                .foregroundStyle(DiveColor.color2)
        }
    }
}
