import SwiftUI

struct CustomTextEditor: View {
    @Binding var text: String
    let placeholder: String = "기록 입력"

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .topLeading) {
                if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Text(placeholder)
                        .font(DiveFont.bodyMedium2)
                        .foregroundStyle(Color(DiveColor.gray3))
                        .padding(.top, 18)
                        .padding(.leading, 18)
                }

                TextEditor(text: limitedText)
                    .font(DiveFont.bodyMedium2)
                    .padding(12)
                    .foregroundColor(.black)
                    .scrollContentBackground(.hidden)
            }
            .frame(height: 140)
            .background(Color(DiveColor.color2).opacity(0.4))
            .applyShadow(DiveShadow.shadow1)
            .cornerRadius(8)

            HStack {
                Spacer()
                Text("\(text.trimmingCharacters(in: .whitespacesAndNewlines).count)/140")
                    .font(DiveFont.bodyMedium2)
                    .foregroundStyle(Color(DiveColor.gray3))
                    .padding(.trailing, 4)
            }
        }
        .onAppear {
            if text.count > 140 {
                text = String(text.prefix(140))
            }
        }
        .onChange(of: text) { newValue in
            if newValue.count > 140 {
                text = String(newValue.prefix(140))
            }
        }
    }

    private var limitedText: Binding<String> {
        Binding<String>(
            get: { String(text.prefix(140)) },
            set: { newValue in
                text = String(newValue.prefix(140))
            }
        )
    }
}
