//
//  BadgeResModel+Mapping.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

struct BadgeResponseModel: Codable {
    let code: String
    let name: String
    let description: String
    let imageUrl: String
}

extension BadgeResponseModel {
    func toDomain(isCollected: Bool) -> Badge {
        return Badge(
            code: code,
            name: name,
            description: description.replacingOccurrences(of: "\\n", with: "\n"),
            imageUrl: imageUrl,
            isCollected: isCollected
        )
    }
}
