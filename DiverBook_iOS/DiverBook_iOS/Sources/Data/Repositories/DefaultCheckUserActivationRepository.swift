//
//  DefaultCheckUserActivationRepository.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//

final class DefaultCheckUserActivationRepository: CheckUserActivationRepository {
    private let checkUserActivationService: DiverBookCheckUserActivationServicable
    
    init(checkUserActivationService: DiverBookCheckUserActivationServicable) {
        self.checkUserActivationService = checkUserActivationService
    }
    
    func checkActivation(userName: String) async -> Result<Bool, Error> {
        let checkActivationResult = await checkUserActivationService.checkActivation(userName: userName)
        switch checkActivationResult {
        case .success(let baseResponse):
            if baseResponse.success, let isActivated = baseResponse.data {
                if isActivated {
                    return .success(true)
                }
                else {
                    return .success(false)
                }
            }
            else {
                return .failure(RequestError.errorWithLog(baseResponse.errorMessage ?? ""))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
