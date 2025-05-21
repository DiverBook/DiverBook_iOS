//
//  DiverBookLogoutServicable.swift
//  DiverBook_iOS
//
//  Created by jun on 5/20/25.
//

import Foundation

protocol DiverBookLogoutServicable: HTTPClient {
    func logout(refreshToken: String) async -> Result<BaseResponse<LogoutResModel>, RequestError>
}
