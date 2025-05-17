//
//  BadgeMeta.swift
//  DiverBook_iOS
//
//  Created by jun on 5/17/25.
//

import Foundation

struct BadgeMeta: Identifiable {
    let code: String
    let name: String
    let description: String
    let condition: String
    let imageName: String

    var id: String { code }

    static let allBadges: [BadgeMeta] = [
        .init(
            code: "B001",
            name: "첫 입수",
            description: "첫 다이버를 등록했어요. 당신의 탐험을 응원합니다.",
            condition: "1명의 다이버를 등록하면 획득할 수 있어요.",
            imageName: "B001"
        ),
        .init(
            code: "B002",
            name: "수면 돌파",
            description: "수면을 뚫고 깊은 곳으로 나아갑니다.",
            condition: "10명의 다이버 등록 시 획득할 수 있어요.",
            imageName: "B002"
        ),
        .init(
            code: "B003",
            name: "심해 탐험가",
            description: "심해 탐험가로 한 걸음 나아가요.",
            condition: "20명의 다이버 등록 시 획득할 수 있어요.",
            imageName: "B003"
        ),
        .init(
            code: "B004",
            name: "숨 고르기 마스터",
            description: "한 템포 쉬어가는 중간 지점에 도달했어요.",
            condition: "30명의 다이버 등록 시 획득할 수 있어요.",
            imageName: "B004"
        ),
        .init(
            code: "B005",
            name: "다이버 콜렉터",
            description: "다채로운 탐험 일지를 채워보았어요.",
            condition: "40명의 다이버 등록 시 획득할 수 있어요.",
            imageName: "B005"
        ),
        .init(
            code: "B006",
            name: "심해의 경계자",
            description: "이제 미지의 다이버들과도 조우할 시간이에요.",
            condition: "50명의 다이버 등록 시 획득할 수 있어요.",
            imageName: "B006"
        ),
        .init(
            code: "B007",
            name: "베테랑 다이버",
            description: "흔들림 없는 노련한 여정자예요.",
            condition: "전체 다이버 수를 모두 등록하면 획득할 수 있어요.",
            imageName: "B007"
        ),
        .init(
            code: "B008",
            name: "레전드 다이버",
            description: "전설로 남을 여정이 완성됐어요.",
            condition: "모든 뱃지를 획득하면 레전드 다이버가 됩니다.",
            imageName: "B008"
        )
    ]
}
