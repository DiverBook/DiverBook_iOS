//
//  View+Ext.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/18/25.
//
import SwiftUI

extension View {
    func hideKeyboardOnTap(action: @escaping () -> Void = { }) -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil, from: nil, for: nil)
            action()
        }
    }
    
    func applyShadow(_ shadow: Shadow) -> some View {
        self.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.positionX,
            y: shadow.positionY)
    }
}
