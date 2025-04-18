//
//  CustomTextEditor.swift
//  DiverProfile
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct CustomTextEditor: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    let backgroundColor: UIColor

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextEditor

        init(_ parent: CustomTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.updatePlaceholderVisibility(in: textView)
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            parent.updatePlaceholderVisibility(in: textView)
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            parent.updatePlaceholderVisibility(in: textView)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.backgroundColor = backgroundColor
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.label
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textView.layer.cornerRadius = 8
        textView.layer.masksToBounds = true

        // Placeholder label
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        placeholderLabel.textColor = UIColor(named: "gray3") ?? .lightGray
        placeholderLabel.numberOfLines = 0
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.tag = 999  // tag로 찾아서 사용

        textView.addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 12),
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 16),
            placeholderLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -16)
        ])

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        updatePlaceholderVisibility(in: uiView)
    }

    fileprivate func updatePlaceholderVisibility(in textView: UITextView) {
        if let placeholderLabel = textView.viewWithTag(999) as? UILabel {
            placeholderLabel.isHidden = !textView.text.isEmpty
        }
    }
}


//#Preview {
//    CustomTextEditor(text: "", placeholder: "", backgroundColor: Color.clear)
//}
