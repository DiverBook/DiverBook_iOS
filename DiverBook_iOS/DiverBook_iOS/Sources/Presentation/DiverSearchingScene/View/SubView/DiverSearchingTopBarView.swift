//
//  DiverSearchingTopBarView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/27/25.
//

import SwiftUI

struct DiverSearchingTopBarView: View {
    var body: some View {
        ZStack {
            TopBar()
            Text("다이버 탐색")
                .font(DiveFont.bar)
                .foregroundColor(DiveColor.gray4)
        }
    }
}
