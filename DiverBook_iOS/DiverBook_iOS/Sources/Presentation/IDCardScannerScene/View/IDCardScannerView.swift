//
//  IDCardScannerView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/10/25.
//

import Combine
import SwiftUI
import UIKit

struct IDCardScannerView: View {
    @StateObject var viewModel: IDCardScannerViewModel

    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: IDCardScannerViewModel(
            coordinator: coordinator,
            checkUserActivationUseCase: DefaultCheckUserActivationUseCase(
                checkUserActivationRepository: DefaultCheckUserActivationRepository(
                    checkUserActivationService: DiverBookCheckUserActivationService()
                )
            )
        ))
    }

    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack(alignment: .top) {
            IDCardScannerContentView(viewModel: viewModel)
            ServiceErrorAlert(
                message: viewModel.state.errorMessage,
                showErrorAlert: $viewModel.state.isErrorShowing
            )
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType = .camera
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(
        _ uiViewController: UIImagePickerController, context: Context
    ) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate,
        UIImagePickerControllerDelegate
    {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController
                .InfoKey: Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    IDCardScannerView(coordinator: coordinator)
}
