//
//  DiverBookLoginService.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//

final class DiverBookLoginService: DiverBookLoginServicable {
    func login(
        userName: String,
        password: String
    ) async -> Result<BaseResponse<LoginResModel>, RequestError> {
        return await request(endpoint: DiverBookAuthEndpoint.login(userName: userName, password: password), responseModel: BaseResponse<LoginResModel>.self)
    }
}
