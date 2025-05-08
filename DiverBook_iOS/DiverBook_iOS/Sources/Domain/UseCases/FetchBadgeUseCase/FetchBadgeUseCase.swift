//
//  FetchBadgeUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

protocol FetchBadgesUseCase {
    func execute() async throws -> [Badge]
}
