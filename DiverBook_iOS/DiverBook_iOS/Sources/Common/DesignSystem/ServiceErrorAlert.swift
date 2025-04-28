//
//  ServiceErrorAlert.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/27/25.
//

import SwiftUI

struct ServiceErrorAlert: View {
    let message: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(DiveColor.color1)
            ServiceErrorContent(message: message)
        }
        .frame(width: 350, height: 55)
    }
}

struct ServiceErrorContent: View {
    let message: String
    
    var body: some View {
        HStack(spacing: 15) {
            RoundedCornerView(
                radius: 10,
                maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner],
                color: DiveColor.color2.opacity(0.4))
                .frame(width: 10)
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundColor(DiveColor.color6)
                .font(.system(size: 26))
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 26)
                .frame(width: 1)
                .foregroundColor(DiveColor.color2)
            Text(message)
                .foregroundColor(DiveColor.color6)
                .font(DiveFont.bodyMediumPretendard)
            Spacer()
        }
    }
}

#Preview {
    ServiceErrorAlert(message: "Service unavailable")
}
