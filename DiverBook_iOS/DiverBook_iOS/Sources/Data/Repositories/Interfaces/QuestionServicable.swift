//
//  QuestionServicable.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/6/25.
//

protocol QuestionServicable: HTTPClient {
    func fetchQuestions(
        count: Int
    ) async -> Result<BaseResponse<[QuestionResModel]>, RequestError>
}
