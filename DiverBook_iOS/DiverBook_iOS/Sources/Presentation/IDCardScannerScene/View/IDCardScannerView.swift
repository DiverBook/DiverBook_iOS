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
        _viewModel = StateObject(wrappedValue: IDCardScannerViewModel(coordinator: coordinator))
    }

    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            IDScannerTopBar()
            Spacer()
            Text("아카데미 출입증을 준비해주세요").font(DiveFont.headingH3)
                .padding(.bottom, 5)
            Text("조명이나 배경에 따라 출입증이 제대로\n촬영되지 않을 수 있어요.")
                .font(DiveFont.bodyMedium2)
                .lineSpacing(3)
                .multilineTextAlignment(.center)
                .padding(.bottom, 45)
            Image("idcard-image").resizable().aspectRatio(contentMode: .fit).frame(width: 241)
            Spacer()
            
            // MARK: 추후 버튼 컴포넌트 사용하도록 수정
            Button(action: {
                CameraManager.shared.requestCameraAccess(
                    isNotAuthorized: {
                        DispatchQueue.main.async {
                            self.viewModel.state.goSettingAlertState = true
                        }
                    },
                    authorized: {
                        DispatchQueue.main.async {
                            self.viewModel.state.showCamera = true
                        }
                    })
            }, label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
                    .frame(height: 55)
                    .overlay(
                        Text("촬영하기")
                            .font(DiveFont.button)
                            .foregroundStyle(.white)
                    )
            })
        }
        .padding(.horizontal, 24)
        .sheet(
            isPresented: self.$viewModel.state.showCamera,
            onDismiss: {
                self.viewModel.action(.inspectImage)
            }
        ) {
            ImagePicker(selectedImage: self.$viewModel.state.capturedImage)
                .ignoresSafeArea()
        }
        .alert(isPresented: self.$viewModel.state.goSettingAlertState) {
            Alert(
                title: Text("현재 카메라 사용에 대한 접근 권한이 없습니다."),
                message: Text("설정 > DiverBook 탭에서 접근을 활성화 할 수 있습니다."),
                primaryButton: .default(
                    Text("설정으로 이동하기"),
                    action: {
                        // MARK: 탭 시 설정 페이지로 이동
                        guard
                            let settingURL = URL(
                                string: UIApplication.openSettingsURLString),
                            UIApplication.shared.canOpenURL(settingURL)
                        else {
                            return
                        }

                        UIApplication.shared.open(settingURL, options: [:])
                    }), secondaryButton: .cancel())
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
