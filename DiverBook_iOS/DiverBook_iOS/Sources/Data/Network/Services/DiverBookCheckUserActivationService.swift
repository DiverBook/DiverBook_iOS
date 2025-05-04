//
//  DiverBookCheckUserActivationService.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//

final class DiverBookCheckUserActivationService: DiverBookCheckUserActivationServicable {
    func checkActivation(userName: String) async -> Result<BaseResponse<Bool>, RequestError> {
        return await request(endpoint: DiverBookAuthEndpoint.checkActivation(userName: userName), responseModel: BaseResponse<Bool>.self)
    }
}
