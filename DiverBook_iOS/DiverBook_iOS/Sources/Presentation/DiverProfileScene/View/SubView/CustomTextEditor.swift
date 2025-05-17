import SwiftUI


struct CustomTextEditor: View {
    @Binding var text: String
    let placeholder: String = "기록 입력"

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text(placeholder)
                    .font(DiveFont.bodyMedium2)
                    .foregroundStyle(Color(DiveColor.gray3))
                    .padding(EdgeInsets(top: 18, leading: 18, bottom: 0, trailing: 0))
            }

            TextEditor(text: $text)
                .font(DiveFont.bodyMedium2)
                .padding(12)
                .foregroundColor(.black)
                .scrollContentBackground(.hidden)
                .onChange(of: text) {
                    if text.count > 140 {
                        text = String(text.prefix(140))
                    }
                }
        }
        .background(Color(DiveColor.color2).opacity(0.4))
        .applyShadow(DiveShadow.shadow1)
        .frame(height: 140)
        .overlay(alignment: .bottomTrailing) {
            Text("\(text.trimmingCharacters(in: .whitespacesAndNewlines).count)/140")
                .font(DiveFont.bodyMedium2)
                .foregroundStyle(Color(DiveColor.gray3))
                .padding(.trailing, 16)
                .padding(.bottom, 10)
        }
    }
}
