//
//  DefaultSaveDiverMemoUseCase.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/11/25.
//

final class DefaultSaveDiverMemoUseCase: SaveDiverMemoUseCase{
    private let diverCollectionRepository: DiverCollectionRepository
    
    init(diverCollectionRepository: DiverCollectionRepository) {
        self.diverCollectionRepository
        = diverCollectionRepository
    }
    
    func executeSaveDiverMemoUseCase(
        foundUserId: String,
        memo: String) async -> Result<CollectedDiverInfo, any Error> {
        return await diverCollectionRepository.saveDiverMemo(foundUserId: foundUserId, memo: memo)
    }
}
