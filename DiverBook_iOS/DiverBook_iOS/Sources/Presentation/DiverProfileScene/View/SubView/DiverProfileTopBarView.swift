//
//  DiverProfileTopBarView.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation
import SwiftUI

struct DiverProfileTopBarView: View {
    var body: some View {
        ZStack {
            TopBar()
            Text("다이버 카드")
                .font(DiveFont.bar)
                .foregroundStyle(DiveColor.gray4)
        }
    }
}
