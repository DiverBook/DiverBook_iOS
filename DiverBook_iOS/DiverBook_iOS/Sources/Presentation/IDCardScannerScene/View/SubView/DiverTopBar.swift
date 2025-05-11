//
//  IDScannerTopBar.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/17/25.
//

import Combine
import SwiftUI

struct TopBar: View {
    @Environment(\.dismiss) var dismiss
    var showBackButton: Bool = true

    var body: some View {
        HStack(spacing: 0) {
            if showBackButton {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12)
                        .foregroundColor(DiveColor.color6)
                })
                .buttonStyle(.plain)
            } else {
                Color.clear.frame(width: 12)
            }
            Spacer()
        }
        .frame(height: 44)
    }
}
