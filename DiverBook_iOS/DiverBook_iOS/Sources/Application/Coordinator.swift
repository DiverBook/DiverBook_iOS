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
    case login(nickname: String)
    case userProfileSetting(nickname: String)
    case idCardScan
    case mainTab
    case searchingDiver
    case unfoundDiver
    case searchResult(diverProfile: DiverProfile)
    case startConversation(id: String)
    case finishConversation(id: String)
    case myProfile
    case diverProfile(id: String)
    case collectedBadge
}
