//
//  ServiceErrorAlert.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/27/25.
//

import SwiftUI

struct ServiceErrorAlert: View {
    let message: String
    @Binding var showErrorAlert: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(DiveColor.color1)
            ServiceErrorContent(message: message)
        }
        .frame(height: 55)
        .padding(.top, 50)
        .padding(.horizontal, 24)
        .opacity(showErrorAlert ? 1 : 0)
        .scaleEffect(showErrorAlert ? 1.0 : 0.8)
        .animation(.easeInOut(duration: 0.4), value: showErrorAlert)
        .onChange(of: showErrorAlert) {
            if showErrorAlert {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    showErrorAlert = false
                }
            }
        }
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
