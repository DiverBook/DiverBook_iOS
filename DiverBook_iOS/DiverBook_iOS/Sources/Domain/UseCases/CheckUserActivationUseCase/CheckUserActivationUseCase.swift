//
//  CheckUserActivationUseCase.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//

protocol CheckUserActivationUseCase {
    func executeCheckActivation(userName: String) async -> Result<Bool, Error>
}
