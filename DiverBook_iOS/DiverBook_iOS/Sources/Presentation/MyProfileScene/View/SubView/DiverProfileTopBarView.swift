//
//  DiverProfileTopBarView.swift
//  DiverBook_iOS
//
//  Created by jun on 5/2/25.
//

import Foundation
import SwiftUI

struct DiverProfileTopBarView: View {
    var body: some View {
        ZStack {
            TopBar()
            Text("내 프로필")
                .font(DiveFont.bar)
                .foregroundColor(DiveColor.gray4)
        }
    }
}
