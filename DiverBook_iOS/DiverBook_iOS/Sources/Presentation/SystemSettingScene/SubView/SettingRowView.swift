//
//  SettingRowView.swift
//  DiverBook_iOS
//
//  Created by jun on 5/2/25.
//

import SwiftUI

struct SettingRowView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundStyle(DiveColor.black)
                    .font(DiveFont.bodyMedium1)
                Spacer()
            }
        }
    }
}

#Preview {
    SettingRowView(title: "내 프로필 관리", action: {})
}
