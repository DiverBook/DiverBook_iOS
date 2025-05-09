//
//  TodayTalkSectionView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import Foundation
import SwiftUI

enum TodayTalkMode {
    case editable(binding: Binding<String>)
    case readOnly(text: String)
}

struct TodayTalkSectionView: View {
    let mode: TodayTalkMode

    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color(DiveColor.white))
                .cornerRadius(8)
                .applyShadow(DiveShadow.shadow1)

            switch mode {
            case .editable(let binding):
                TextField("오늘의 한마디를 입력해주세요", text: binding)
                    .font(DiveFont.bodyMedium2)
                    .multilineTextAlignment(.center)
                    .padding(16)
            case .readOnly(let text):
                Text(text.isEmpty ? "오늘의 한마디가 없습니다" : text)
                    .font(DiveFont.bodyMedium2)
                    .multilineTextAlignment(.center)
                    .padding(16)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
    }
}

#Preview {
    VStack(spacing: 40) {
        TodayTalkSectionView(mode: .editable(binding: .constant("오늘 날씨가 좋네요")))
            .padding()
//        TodayTalkSectionView(mode: .readOnly(text: "오늘은 날씨가 좋네요"))
    }
}
