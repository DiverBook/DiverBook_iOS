//
//  IDCardScannerViewModel.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/10/25.
//

import Combine
import CoreImage
import SwiftUI

final class IDCardScannerViewModel: ViewModelable {
    struct State {
        var showCamera = false
        var isScanning = false
        var capturedImage: UIImage?
        var inspectionResult: String?
        var goSettingAlertState: Bool = false
    }
    
    enum Action {
        case scanningButtonTapped
        case inspectImage
    }
    
    private let checkUserActivationUseCase: CheckUserActivationUseCase
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator, checkUserActivationUseCase: CheckUserActivationUseCase) {
        self.coordinator = coordinator
        self.checkUserActivationUseCase = checkUserActivationUseCase
    }
    
    func action(_ action: Action) {
        switch action {
        case .scanningButtonTapped:
            state.isScanning = true
            startScanning()
        case .inspectImage:
            if let image = self.state.capturedImage {
                Task {
                    let result = await inspectImage(image: image)
                    switch result {
                    case .success(let nickname):
                        // 해당 닉네임의 유저 정보 존재 여부에 따라 profileSetting, login 분기
                        let checkActivationResult = await self.checkUserActivationUseCase.executeCheckActivation(userName: nickname)
                        switch checkActivationResult {
                        case .success(let isActivated):
                            if isActivated {
                                self.coordinator.push(.login(nickname: nickname))
                            }
                            else {
                                self.coordinator.push(.userProfileSetting(nickname: nickname))
                            }
                        case .failure(let error):
                            // TODO: 네트워크 통신 관련 실패 모달 띄우기
                            print(error)
                        }
                    case .failure(let error):
                        // TODO: 출입증 카드 검사 실패 실패 모달 띄우기
                        print(error)
                    }
                    state.isScanning = false
                }
            }
            else {
                state.isScanning = false
            }
        }
    }
        
    private func inspectImage(image: UIImage) async -> Result<String, VisionError> {
        let idCardClassificationResult = await withCheckedContinuation({ continuation in
            MLModelManager.shared.inspectIdCard(image: CIImage(image: image)!, completion: { isIdCard in
                continuation.resume(returning: isIdCard)
            })
        })
        
        if idCardClassificationResult.identifier.capitalized == "Idcard" {
            let idCardTextOCRResult = await withCheckedContinuation({ continuation in
                MLModelManager.shared.inspectNickname(image: image) { text in
                    continuation.resume(returning: text)
                }
            })
            guard idCardTextOCRResult != nil else {
                return .failure(.readIdCardNicknameFailed)
            }
            return .success(idCardTextOCRResult!)
        } else {
            return .failure(.isNotIdCard)
        }
    }
    
    private func startScanning() {
        CameraManager.shared.requestCameraAccess(
            isNotAuthorized: {
                DispatchQueue.main.async {
                    self.state.goSettingAlertState = true
                }
            },
            authorized: {
                DispatchQueue.main.async {
                    self.state.showCamera = true
                }
            })
    }
}
