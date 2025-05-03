//
//  AuthRepository.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/28/25.
//

protocol AuthRepository {
    func signUp(
        userName: String,
        divisions: String,
        phoneNumber: String,
        interests: String,
        places: String,
        about: String,
        password: String
    ) async -> Result<Bool, Error>
    
    func refreshToken(
        refreshToken: String
    ) async -> Result<AuthInfo, Error>
}
