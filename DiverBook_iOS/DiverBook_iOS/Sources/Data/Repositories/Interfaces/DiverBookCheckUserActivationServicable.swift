//
//  CheckUserActivationServicable.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//

protocol DiverBookCheckUserActivationServicable: HTTPClient {
    func checkActivation(userName: String) async -> Result<BaseResponse<Bool>, RequestError>
}
