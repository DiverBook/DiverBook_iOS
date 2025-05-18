//
//  DiverXMarkBar.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/18/25.
//

import SwiftUI

struct XMarkBar: View {
    let coordinator: Coordinator

    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            Button(action: {
                coordinator.path = [.mainTab]
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 17)
                    .foregroundColor(DiveColor.color6)
            })
            .buttonStyle(.plain)
        }
        .frame(height: 44)
    }
}
