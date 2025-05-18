//
//  PostUserBadgeUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/12/25.
//

import Foundation

protocol PostUserBadgeUseCase {
    func executePostUserBadge(badgeCode: String) async throws -> CollectedBadge
}
