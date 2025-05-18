//
//  IDCardScannerContentView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/7/25.
//

import SwiftUI

struct IDCardScannerContentView: View {
    @ObservedObject var viewModel: IDCardScannerViewModel
    @GestureState var dragOffset: CGSize = .zero
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            TopBar()
            Spacer().frame(height: 60)
            Text("아카데미 출입증을 준비해주세요").font(DiveFont.headingH3).bold()
                .padding(.bottom, 10)
            Text("조명이나 배경에 따라 출입증이 제대로\n촬영되지 않을 수 있어요.")
                .font(DiveFont.bodyMedium2)
                .foregroundStyle(DiveColor.gray3)
                .lineSpacing(3)
                .multilineTextAlignment(.center)
                .padding(.bottom, 55)
            Image("idcard-image").resizable().aspectRatio(contentMode: .fit).frame(width: 240)
            Spacer()
            
            PrimaryButton(title: "촬영하기", coordinator: Coordinator()) {
                viewModel.action(.scanningButtonTapped)
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 24)
        .background(.white)
        .setBackGesture(
            dragOffset: $dragOffset,
            dismiss: { dismiss() }
        )
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
        .overlay(
            VStack {
                Spacer()
                    .frame(height: 100)
                Text("촬영 정보를 불러오는 중입니다")
                    .font(DiveFont.headingH3)
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(.white)
            .overlay(
                ProgressView()
            )
            .opacity(viewModel.state.isScanning ? 1 : 0)
        )
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    IDCardScannerContentView(viewModel: IDCardScannerViewModel(coordinator: coordinator, checkUserActivationUseCase: DefaultCheckUserActivationUseCase(checkUserActivationRepository: DefaultCheckUserActivationRepository(checkUserActivationService: DiverBookCheckUserActivationService()))))
}
