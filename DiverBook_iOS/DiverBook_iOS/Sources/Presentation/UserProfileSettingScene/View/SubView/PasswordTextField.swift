//
//  PasswordTextField.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/30/25.
//

import Combine
import SwiftUI

struct PasswordTextField: View {
    @Binding var password: String
    @State private var isHidden: Bool = true
    
    var body: some View {
        HStack {
            if isHidden {
                SecureField("", text: $password)
                    .keyboardType(.numberPad)
            } else {
                TextField("", text: $password)
                    .keyboardType(.numberPad)
            }
            Button(action: {
                isHidden.toggle()
            }, label: {
                Image("visible")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22)
            })
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    @Previewable @State var password: String = ""
    PasswordTextField(password: $password)
}
