//
//  Badge.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import Foundation

struct Badge: Identifiable {
    let id = UUID()
    let name: String
    let requiredDiverCount: Int
    let imageName: String
}
