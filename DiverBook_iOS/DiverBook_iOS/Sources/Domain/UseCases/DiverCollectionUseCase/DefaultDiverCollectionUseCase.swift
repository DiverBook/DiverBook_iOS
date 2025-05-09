//
//  DefaultDiverCollectionUseCase.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//

final class DefaultDiverCollectionUseCase: DiverCollectionUseCase {
    
    private let diverCollectionRepository: DiverCollectionRepository
    
    init(diverCollectionRepository: DiverCollectionRepository) {
        self.diverCollectionRepository = diverCollectionRepository
    }
    
    func executeFetchAllDiverList() async -> Result<[DiverProfile], Error> {
        let allDiverListResult = await diverCollectionRepository.fetchAllDiverList()
        switch allDiverListResult {
        case .success(let diverProfiles):
            return .success(diverProfiles)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func executeFetchDiverCollection() async -> Result<[CollectedDiverInfo], Error> {
        let diverCollectionResult = await diverCollectionRepository.fetchDiverCollection()
        switch diverCollectionResult {
        case .success(let diverProfiles):
            return .success(diverProfiles)
        case .failure(let error):
            return .failure(error)
        }
    }
}
