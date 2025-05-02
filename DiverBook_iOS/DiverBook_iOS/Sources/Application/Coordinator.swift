//
//  Coordinator.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/14/25.
//

import Combine
import SwiftUI

class Coordinator: ObservableObject {
    @Published var path: [Path] = []
    
    init() { }
    
    func push(_ path: Path) {
        self.path.append(path)
    }
    
    func pop() {
        _ = self.path.popLast()
    }
}

// MARK: - navigating 되는 뷰 case 분리
enum Path: Hashable {
    case splash
    case userProfileSetting(nickname: String)
    case idCardScan
    case mainTab
    case searchingDiver
    case searchResult(nickname: String)
    case startConversation
    case finishConversation
    case myProfile
    case privacyPolicy
    case settingTab
}
