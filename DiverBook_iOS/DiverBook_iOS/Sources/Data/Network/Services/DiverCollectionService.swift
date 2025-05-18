//
//  DiverCollectionService.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//
import Foundation

final class DiverCollectionService: DiverCollectionServicable {
    private let session: URLSession
    
    init() {
        let memoryCapacity = 50 * 1024 * 1024
        let diskCapacity = 100 * 1024 * 1024
        let urlCache = URLCache(
            memoryCapacity: memoryCapacity,
            diskCapacity: diskCapacity,
            diskPath: "DiverBookCache"
        )
        
        let config = URLSessionConfiguration.default
        config.urlCache = urlCache
        config.requestCachePolicy = .returnCacheDataElseLoad
        self.session = URLSession(configuration: config)
    }
    func fetchAllDiverList() async -> Result<BaseResponse<[DiverProfileResModel]>, RequestError> {
        return await request(
            endpoint: DiverCollectionEndpoint.allDiverList,
            responseModel: BaseResponse<[DiverProfileResModel]>.self,
            session: session
        )
    }
    
    func fetchDiverCollection() async -> Result<BaseResponse<[CollectedDiverResModel]>, RequestError> {
        return await request(
            endpoint: DiverCollectionEndpoint.diverCollection,
            responseModel: BaseResponse<[CollectedDiverResModel]>.self,
            session: session
        )
    }
    
    func updateDiverMemo(foundUserId: String, memo: String) async -> Result<BaseResponse<CollectedDiverResModel>, RequestError> {
        return await request(
            endpoint: DiverCollectionEndpoint.updateDiverMemo(foundUserId: foundUserId, memo: memo),
            responseModel: BaseResponse<CollectedDiverResModel>.self,
            session: session
        )
    }
    
    func saveDiverMemo(foundUserId: String, memo: String) async -> Result<BaseResponse<CollectedDiverResModel>, RequestError> {
        return await request(
            endpoint: DiverCollectionEndpoint.saveDiverMemo(foundUserId: foundUserId, memo: memo),
            responseModel: BaseResponse<CollectedDiverResModel>.self,
            session: session
        )
    }
}
