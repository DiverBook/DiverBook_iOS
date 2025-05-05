//
//  DefaultCheckUserActivationUseCase.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//

final class DefaultCheckUserActivationUseCase: CheckUserActivationUseCase {
    private let checkUserActivationRepository: CheckUserActivationRepository
    
    init(checkUserActivationRepository: CheckUserActivationRepository) {
        self.checkUserActivationRepository = checkUserActivationRepository
    }
    
    func executeCheckActivation(userName: String) async -> Result<Bool, Error> {
        return await checkUserActivationRepository.checkActivation(userName: userName)
    }
}
