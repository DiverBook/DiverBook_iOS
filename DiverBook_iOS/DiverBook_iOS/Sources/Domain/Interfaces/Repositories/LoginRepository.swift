//
//  LoginRepository.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//

protocol LoginRepository {
    func login(userName: String, password: String) async -> Result<AuthInfo, Error>
}
