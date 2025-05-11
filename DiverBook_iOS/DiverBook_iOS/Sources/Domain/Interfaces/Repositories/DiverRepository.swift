//
//  DiverRepository.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/1/25.
//

protocol DiverRepository {
    func fetchProfileImageUrl(nickName: String) async -> Result<String, Error>
    func fetchDiverProfile(id: String) async -> Result<DiverProfile, Error>
    func fetchMyProfile() async -> Result<DiverProfile, Error>
    func updateMyProfile(
        divisions: String,
        phoneNumber: String,
        interests: String,
        places: String,
        about: String
    ) async -> Result<DiverProfile, Error>
}
