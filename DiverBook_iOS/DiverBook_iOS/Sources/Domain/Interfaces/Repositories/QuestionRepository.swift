//
//  QuestionRepository.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/6/25.
//

protocol QuestionRepository {
    func fetchQuestions(
        count: Int
    ) async -> Result<[Question], Error>
}
