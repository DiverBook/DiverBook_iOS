//
//  BadgeRepository.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

protocol BadgeRepository {
    func fetchAllBadges() async throws -> [Badge]
}
