//
//  VersionInfoView.swift
//  DiverBook_iOS
//
//  Created by jun on 5/2/25.
//

import SwiftUI

struct VersionInfoView: View {
    var body: some View {
        HStack {
            Spacer()
            
            Text("버전 정보 \(Version.current)")
                .foregroundStyle(DiveColor.gray2)
                .font(DiveFont.bodyMedium1)
        }
    }
}

#Preview {
    VersionInfoView()
}
