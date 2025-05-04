//
//  DiverRepository.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/1/25.
//

protocol DiverRepository {
    func fetchDiverProfile(id: String) async -> Result<DiverProfile, Error>
}
