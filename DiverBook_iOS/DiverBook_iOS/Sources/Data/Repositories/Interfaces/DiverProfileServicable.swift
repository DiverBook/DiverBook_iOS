//
//  DiverProfileServicable.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/1/25.
//

protocol DiverProfileServicable: HTTPClient {
    func fetchDiverProfile(
        id: String
    ) async -> Result<BaseResponse<DiverProfileResModel>, RequestError>
}
