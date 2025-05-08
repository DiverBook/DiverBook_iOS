//
//  Badge.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import Foundation

struct Badge: Identifiable {
    let code: String
    let name: String
    let description: String
    let imageUrl: String
    let isCollected: Bool
    
    var id: String { code }
}
