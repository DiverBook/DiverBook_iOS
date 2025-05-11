//
//  SaveDiverMemoUseCase.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/11/25.
//

protocol SaveDiverMemoUseCase{
    func executeSaveDiverMemoUseCase(
        foundUserId: String,
        memo: String) async -> Result<CollectedDiverInfo, Error>
}
