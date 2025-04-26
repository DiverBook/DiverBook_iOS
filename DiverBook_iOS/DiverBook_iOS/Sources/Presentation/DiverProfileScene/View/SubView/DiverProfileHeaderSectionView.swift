//
//  DiverProfileHeaderSectionView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import Foundation
import SwiftUI

struct DiverProfileHeaderSectionView: View {
    let name: String
    let foundDate: String
    
    var body: some View {
        HStack(spacing: 11) {
            PrimaryProfile(image: Image("exMemoji"), style: .basic)

            VStack(alignment: .leading, spacing: 6) {
                Text(name)
                    .font(DiveFont.headingH2)

                Text("발견일자: \(foundDate)")
                    .font(DiveFont.bodyMedium2)
                    .foregroundStyle(DiveColor.color5)
            }
            Spacer()
        }
    }
}

#Preview {
    DiverProfileHeaderSectionView(name: "Chloe", foundDate: "25.03.24")
}
