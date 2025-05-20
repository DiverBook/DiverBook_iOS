//
//  LogoutUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/20/25.
//

import Foundation

protocol LogoutUseCase {
    func executeLogout(refreshToken: String) async -> Result<AuthInfo, Error>
}
