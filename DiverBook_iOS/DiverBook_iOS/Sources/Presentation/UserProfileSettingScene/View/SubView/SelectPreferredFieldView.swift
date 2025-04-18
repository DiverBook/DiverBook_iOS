//
//  SelectPreferredFieldView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/18/25.
//

import Combine
import SwiftUI

struct SelectPreferredFieldView: View {

    @Binding var selectedPreferredField: PreferredField

    var body: some View {
        HStack(spacing: 0) {
            ForEach(PreferredField.allCases, id: \.self) { field in
                Text(field.fieldDescription)
                    .font(DiveFont.bodyMedium2)
                    .foregroundStyle(
                        self.selectedPreferredField == field
                            ? .white : DiveColor.gray3
                    )
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(
                        Capsule().fill(
                            self.selectedPreferredField == field
                                ? DiveColor.color4 : .white
                        )
                        .stroke(
                            self.selectedPreferredField == field
                                ? .clear : DiveColor.gray2, lineWidth: 1)
                    )
                    .onTapGesture {
                        withAnimation {
                            self.selectedPreferredField = field
                        }
                    }
                    .padding(.trailing, 14)
            }
        }
    }
}

#Preview {
    @Previewable @State var field: PreferredField = .tech
    SelectPreferredFieldView(selectedPreferredField: $field)
}
