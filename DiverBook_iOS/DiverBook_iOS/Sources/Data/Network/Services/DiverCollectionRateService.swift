//
//  DiverCollectionRateService.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//

final class DiverCollectionRateService: DiverCollectionRateServicable {
    func fetchDiverCollectionRate(id: String) async -> Result<BaseResponse<Float>, RequestError> {
        return await request(endpoint: DiverCollectionEndpoint.diverCollectionRate(id: id), responseModel: BaseResponse<Float>.self)
    }
}
