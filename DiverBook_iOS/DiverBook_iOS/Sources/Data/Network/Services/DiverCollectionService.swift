//
//  DiverCollectionService.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//

final class DiverCollectionService: DiverCollectionServicable {
    func fetchAllDiverList() async -> Result<BaseResponse<[DiverProfileResModel]>, RequestError> {
        return await request(
            endpoint: DiverCollectionEndpoint.allDiverList,
            responseModel: BaseResponse<[DiverProfileResModel]>.self
        )
    }
    
    func fetchDiverCollection() async -> Result<BaseResponse<[CollectedDiverResModel]>, RequestError> {
        return await request(
            endpoint: DiverCollectionEndpoint.diverCollection,
            responseModel: BaseResponse<[CollectedDiverResModel]>.self
        )
    }
}
