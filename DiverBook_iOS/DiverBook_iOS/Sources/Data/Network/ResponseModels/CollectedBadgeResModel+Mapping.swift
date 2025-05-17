//
//  CollectedBadgeResModel+Mapping.swift
//  DiverBook_iOS
//
//  Created by jun on 5/17/25.
//

import Foundation

struct CollectedBadgeResModel: Codable {
    let id: Int
    let userId: String
    let badgeCode: String
    let acquiredDate: String
}

extension CollectedBadgeResModel {
    func toDomain() -> CollectedBadge {
        return CollectedBadge(
            id: id,
            userId: userId,
            badgeCode: badgeCode,
            acquiredDate: acquiredDate
        )
    }
}
