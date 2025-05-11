//
//  DefaultFetchDiverProfileUseCase.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/1/25.
//

final class DefaultFetchDiverProfileUseCase: FetchDiverProfileUseCase {
    private let repository: DiverRepository
    
    init(repository: DiverRepository) {
        self.repository = repository
    }
    
    func executeFetchProfileImageUrl(nickName: String) async -> Result<String, Error> {
        return await repository.fetchProfileImageUrl(nickName: nickName)
    }
    
    func executeFetchProfile(id: String) async -> Result<DiverProfile, Error> {
        return await repository.fetchDiverProfile(id: id)
    }
    
    func executeFetchMyProfile() async -> Result<DiverProfile, Error> {
        return await repository.fetchMyProfile()
    }
}
