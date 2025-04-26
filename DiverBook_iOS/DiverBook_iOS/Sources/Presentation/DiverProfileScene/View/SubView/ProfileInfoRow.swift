//
//  ProfileInfoRow.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import Foundation
import SwiftUI

struct ProfileInfoRow: View {
    var title: String
    var content: String

    var body: some View {
        HStack {
            Text(title)
                .font(DiveFont.bodyLarge)
                .foregroundStyle(DiveColor.gray3)

            Spacer()

            Text(content)
                .font(DiveFont.bodyPretendard)
        }
    }
}

#Preview {
    ProfileInfoRow(title: "희망분야", content: "디자인")
}
