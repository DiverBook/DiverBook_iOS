//
//  DiverCollectionRateServicable.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//

protocol DiverCollectionRateServicable: HTTPClient {
    func fetchDiverCollectionRate(id: String) async -> Result<BaseResponse<Float>, RequestError>
}
