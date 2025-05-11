//
//  UpdateDiverMemoUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/11/25.
//

import Foundation

protocol UpdateDiverMemoUseCase{
    func executeUpdateDiverMemoUseCase(foundUserId: String, memo: String) async -> Result<CollectedDiverInfo, Error>
}
