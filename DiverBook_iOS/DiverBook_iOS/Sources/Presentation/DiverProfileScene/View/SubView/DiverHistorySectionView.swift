//
//  DiverHistorySectionView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import Foundation
import SwiftUI

struct DiverHistorySectionView: View {
    @Binding var history: String
    @FocusState var memoFocused: Bool

    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Text("다이버에 대한 기록을 남겨보세요")
                    .font(DiveFont.bodyLarge)
                    .foregroundStyle(DiveColor.gray3)
                Spacer()
            }
            
            CustomTextEditor(text: $history, memoFocused: _memoFocused)
        }
    }
}

#Preview {
    DiverHistorySectionView(history: .constant(""))
}
