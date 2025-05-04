//
//  PrivacyPolicyTopBarView.swift
//  DiverBook_iOS
//
//  Created by jun on 5/2/25.
//

import SwiftUI

struct PrivacyPolicyTopBarView: View {
    var body: some View {
        ZStack {
            TopBar()
            Text("개인정보 이용 약관")
                .font(DiveFont.bar)
                .foregroundColor(DiveColor.gray4)
        }
    }
}

#Preview {
    PrivacyPolicyTopBarView()
}
