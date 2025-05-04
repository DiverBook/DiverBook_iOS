//
//  BaseResponse.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/3/25.
//

struct BaseResponse<T: Decodable>: Decodable {
    let success: Bool
    let data: T?
    let errorMessage: String?
}
