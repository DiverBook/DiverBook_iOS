//
//  UserDeactivateService.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

final class UserDeactivateService: UserDeactivateServicable {
    func deactivateUser(refreshToken: String) async -> Result<BaseResponse<DiverProfileResModel>, RequestError> {
        return await request(
            endpoint: UserDeactivateEndpoint.deactivate(refreshToken: refreshToken),
            responseModel: BaseResponse<DiverProfileResModel>.self
        )
    }
}
