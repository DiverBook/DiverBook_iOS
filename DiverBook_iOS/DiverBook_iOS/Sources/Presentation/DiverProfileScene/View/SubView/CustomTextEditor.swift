import SwiftUI

struct CustomTextEditor: View {
    @Binding var text: String
    let placeholder: String = "기록 입력"

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(DiveFont.bodyMedium2)
                    .foregroundStyle(Color(DiveColor.gray3))
                    .padding(
                        EdgeInsets(top: 18, leading: 18, bottom: 0, trailing: 0)
                    )
            }

            TextEditor(text: $text)
                .font(DiveFont.bodyMedium2)
                .padding(12)
                .foregroundColor(.black)
                .scrollContentBackground(.hidden)
        }
        .background(Color(DiveColor.color2).opacity(0.4))
        .shadow(
            color: Color.black.opacity(0.15),
            radius: 7,
            x: 0,
            y: 2
        )
        .frame(height: 140)
        .overlay(alignment: .bottomTrailing) {
            Text("\(text.count)/140")
                .font(DiveFont.bodyMedium2)
                .foregroundStyle(Color(DiveColor.gray3))
                .padding(.trailing, 16)
                .padding(.bottom, 10)
        }
    }
}

#Preview {
    CustomTextEditor(text: .constant(""))
}
