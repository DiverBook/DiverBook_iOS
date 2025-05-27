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
        guard self.path.count >= 2 else {
            self.path.append(path)
            return
        }
        
        let last = self.path.last!
        let secondLast = self.path[self.path.count - 2]
        
        if last.caseName == secondLast.caseName {
            return
        }
        
        self.path.append(path)
    }
    
    func pop() {
        _ = self.path.popLast()
    }
}

// MARK: - navigating 되는 뷰 case 분리
enum Path: Hashable, Equatable {
    case splash
    case login(nickname: String)
    case userProfileSetting(nickname: String)
    case idCardScan
    case mainTab
    case searchingDiver
    case unfoundDiver(nickname: String)
    case searchResult(diverProfile: DiverProfile, hasBeenFound: Bool)
    case startConversation(id: String)
    case checkConversation(id: String)
    case finishConversation(id: String)
    case myProfile
    case diverProfile(id: String)
    case collectedBadge
    case badgeReward(badgeCode: String)
}

extension Path {
    var caseName: String {
        switch self {
        case .splash: return "splash"
        case .login: return "login"
        case .userProfileSetting: return "userProfileSetting"
        case .idCardScan: return "idCardScan"
        case .mainTab: return "mainTab"
        case .searchingDiver: return "searchingDiver"
        case .unfoundDiver: return "unfoundDiver"
        case .searchResult: return "searchResult"
        case .startConversation: return "startConversation"
        case .checkConversation: return "checkConversation"
        case .finishConversation: return "finishConversation"
        case .myProfile: return "myProfile"
        case .diverProfile: return "diverProfile"
        case .collectedBadge: return "collectedBadge"
        case .badgeReward: return "badgeReward"
        }
    }
}
