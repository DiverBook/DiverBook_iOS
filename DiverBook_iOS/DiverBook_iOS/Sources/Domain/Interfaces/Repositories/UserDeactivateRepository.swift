//
//  UserDeactivateRepository.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

protocol UserDeactivateRepository {
    func deactivateUser() async -> Result<DiverProfile, Error>
}
