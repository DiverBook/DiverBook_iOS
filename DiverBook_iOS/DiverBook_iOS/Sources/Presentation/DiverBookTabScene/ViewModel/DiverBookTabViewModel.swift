//
//  DiverBookTabViewModel.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/15/25.
//

import Combine
import SwiftUI

final class DiverBookTabViewModel: ViewModelable {
    struct State {
        var selectedTab: TabType = .diverBook
    }
    
    enum Action {
        
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        
    }
}
