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
        var capturedImage: UIImage?
        var inspectionResult: String?
        var goSettingAlertState: Bool = false
    }

    enum Action {
        case inspectImage
    }

    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func action(_ action: Action) {
        switch action {
        case .inspectImage:
            if let image = self.state.capturedImage {
                Task {
                    let result = await inspectImage(image: image)
                    switch result {
                    case .success(let nickname):
                        self.coordinator.push(
                            .userProfileSetting(nickname: nickname))
                    case .failure(let failure):
                        // MARK: 실패 모달 띄우기
                        print(failure)
                    }
                }
            }
        }
    }

    private func inspectImage(image: UIImage) async -> Result<String, VisionError> {
        let idCardClassificationResult = await withCheckedContinuation({
            continuation in
            MLModelManager.shared.inspectIdCard(
                image: CIImage(image: image)!,
                completion: { isIdCard in
                    continuation.resume(returning: isIdCard)
                })
        })

        if idCardClassificationResult.identifier.capitalized == "Idcard" {
            let idCardTextOCRResult = await withCheckedContinuation({
                continuation in
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
}
