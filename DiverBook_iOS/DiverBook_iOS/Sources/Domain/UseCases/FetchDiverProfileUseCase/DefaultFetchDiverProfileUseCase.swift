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
    
    func executeFetchProfile(id: String) async -> Result<DiverProfile, Error> {
        return await repository.fetchDiverProfile(id: id)
    }
}
