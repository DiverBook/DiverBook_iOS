//
//  QuestionService.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/6/25.
//

final class QuestionService: QuestionServicable {
    func fetchQuestions(
        count: Int
    ) async -> Result<BaseResponse<[QuestionResModel]>, RequestError> {
        return await request(
            endpoint: QuestionEndpoint.fetchQuestions(count: count),
            responseModel: BaseResponse<[QuestionResModel]>.self
        )
    }
}
