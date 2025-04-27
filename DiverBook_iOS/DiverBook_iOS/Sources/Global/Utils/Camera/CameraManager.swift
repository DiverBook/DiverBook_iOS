//
//  CameraManager.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/11/25.
//

import AVFoundation
import Foundation

final class CameraManager {
    static var shared: CameraManager = CameraManager()

    private init() {

    }

    func requestCameraAccess(
        isNotAuthorized: @escaping () -> Void, authorized: @escaping () -> Void
    ) {
        AVCaptureDevice.requestAccess(for: .video) { isAuthorized in
            guard isAuthorized else {
                isNotAuthorized()
                return
            }

            authorized()
        }

    }
}
