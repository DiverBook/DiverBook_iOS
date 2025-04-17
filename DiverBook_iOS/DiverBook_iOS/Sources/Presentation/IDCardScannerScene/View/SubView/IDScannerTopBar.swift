//
//  IDScannerTopBar.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/17/25.
//

import Combine
import SwiftUI

struct IDScannerTopBar: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12)
            })
            .buttonStyle(.plain)
            Spacer()
        }
        .frame(height: 44)
    }
}
