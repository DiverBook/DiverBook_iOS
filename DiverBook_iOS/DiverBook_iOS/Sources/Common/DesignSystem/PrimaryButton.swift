//
//  Untitled.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/18/25.
//

import SwiftUI

struct PrimaryButton<Destination: View>: View {
    let title: String
    let isEnabled: Bool
    let color: PrimaryButtonColor
    let destination: Destination?
    let action: () -> Void
    
    init(title: String,
         isEnabled: Bool = true,
         color: PrimaryButtonColor = .darker,
         destination: Destination? = nil,
         action: @escaping () -> Void) {
        self.title = title
        self.isEnabled = isEnabled
        self.color = color
        self.destination = destination
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
        Group {
            if let destination = destination, isEnabled {
                NavigationLink(destination: destination) {
                    buttonLabel
                }
                .simultaneousGesture(TapGesture().onEnded {
                    action()
                })
                .disabled(!isEnabled)
            } else {
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
    }
}

enum PrimaryButtonColor {
    case darker
    case lighter
}

#Preview {
    PrimaryButton(title: "활성화", destination: EmptyView()) {
        print("버튼 클릭")
    }
}
