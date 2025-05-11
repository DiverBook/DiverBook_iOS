//
//  DefaultUpdateDiverMemoUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/11/25.
//

import Foundation

final class DefaultUpdateDiverMemoUseCase: UpdateDiverMemoUseCase{
    private let diverCollectionRepository: DiverCollectionRepository
    
    init(diverCollectionRepository: DiverCollectionRepository) {
        self.diverCollectionRepository
        = diverCollectionRepository
    }
    
    func executeUpdateDiverMemoUseCase(
        foundUserId: String,
        memo: String) async -> Result<CollectedDiverInfo, any Error> {
        return await diverCollectionRepository.updateDiverMemo(foundUserId: foundUserId, memo: memo)
    }
}
