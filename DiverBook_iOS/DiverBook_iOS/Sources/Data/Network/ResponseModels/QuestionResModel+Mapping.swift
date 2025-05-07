//
//  QuestionResModel+Mapping.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/6/25.
//

struct QuestionResModel: Decodable {
    let id: Int
    let question: String
    let symbol: String
}

extension QuestionResModel {
    func toDomain() -> Question {
        return .init(
            id: id,
            question: question,
            symbol: symbol
        )
    }
}

extension Array where Element == QuestionResModel {
    func toDomainList() -> [Question] {
        return self.map { $0.toDomain() }
    }
}
