//
//  Untitled.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/18/25.
//

import SwiftUI

struct PrimaryButton: View {
    @ObservedObject var coordinator: Coordinator

    let title: String
    let isEnabled: Bool
    let color: PrimaryButtonColor
    let action: () -> Void
    
    init(title: String,
         isEnabled: Bool = true,
         color: PrimaryButtonColor = .darker,
         coordinator: Coordinator,
         action: @escaping () -> Void) {
        self.title = title
        self.isEnabled = isEnabled
        self.color = color
        self.coordinator = coordinator
        self.action = action
    }
    
    private var buttonLabel: some View {
        let backgroundColor: Color
        let textColor = isEnabled ? DiveColor.white : DiveColor.gray3
        
        if isEnabled {
            switch color {
            case .darker:
                backgroundColor = DiveColor.color6
            case .lighter:
                backgroundColor = DiveColor.color4
            }
        } else {
            backgroundColor = DiveColor.gray1
        }
        
        return Text(title)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .foregroundColor(textColor)
            .background(backgroundColor)
            .cornerRadius(10)
    }
    
    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }, label: {
            buttonLabel
        })
        .disabled(!isEnabled)
    }
}

enum PrimaryButtonColor {
    case darker
    case lighter
}

#Preview {
    // 진한 색상 활성상태 버튼
    PrimaryButton(title: "활성화", coordinator: Coordinator()) {}
    // 연한 색상 활성상태 버튼
    PrimaryButton(title: "활성화", color: .lighter, coordinator: Coordinator()) {}
    // 비활성상태 버튼
    PrimaryButton(title: "비활성화", isEnabled: false, coordinator: Coordinator()) {}
}
