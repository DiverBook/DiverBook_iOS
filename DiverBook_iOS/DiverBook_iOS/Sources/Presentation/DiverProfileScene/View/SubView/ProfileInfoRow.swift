//
//  ProfileInfoRow.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import Foundation
import SwiftUI

enum ProfileInfoMode {
    case editable(binding: Binding<String>)
    case readOnly(text: String)
}

struct ProfileInfoRow: View {
    var title: String
    var mode: ProfileInfoMode

    var body: some View {
        HStack {
            Text(title)
                .font(DiveFont.bodyLarge)
                .foregroundStyle(DiveColor.gray3)

            Spacer()

            switch mode {
            case .editable(let binding):
                TextField("", text: binding)
                    .multilineTextAlignment(.trailing)
                    .font(DiveFont.bodyPretendard)

            case .readOnly(let text):
                Text(text)
                    .font(DiveFont.bodyPretendard)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

#Preview {
    VStack {
        ProfileInfoRow(title: "희망분야", mode: .editable(binding: .constant("디자인")))
        ProfileInfoRow(title: "희망분야", mode: .readOnly(text: "디자인"))
    }
}
