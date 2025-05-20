//
//  LogoutRepository.swift
//  DiverBook_iOS
//
//  Created by jun on 5/20/25.
//

import Foundation

protocol LogoutRepository {
    func logout(refreshToken: String) async -> Result<AuthInfo, Error>
}
