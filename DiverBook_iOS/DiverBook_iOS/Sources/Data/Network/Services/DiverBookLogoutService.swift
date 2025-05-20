//
//  DiverBookLogoutService.swift
//  DiverBook_iOS
//
//  Created by jun on 5/20/25.
//

import Foundation

final class DiverBookLogoutService: DiverBookLogoutServicable {
    func logout(refreshToken: String) async -> Result<BaseResponse<LogoutResModel>, RequestError> {
        return await request(
            endpoint: DiverBookAuthEndpoint.logout(refreshToken: refreshToken),
            responseModel: BaseResponse<LogoutResModel>.self
        )
    }
}
