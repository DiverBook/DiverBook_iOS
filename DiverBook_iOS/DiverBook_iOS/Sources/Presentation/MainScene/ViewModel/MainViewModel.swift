//
//  MainViewModel.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/7/25.
//

import Combine
import SwiftUI

class MainViewModel: ViewModelable {
    struct State {
        
    }
    
    enum Action {
        
    }
    
    @Published var state: State = State()
    
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        //
    }
}
