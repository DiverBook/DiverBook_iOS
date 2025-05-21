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
    let rewardDescription: String
    let description: String
    let condition: String
    let imageName: String
    let isCollected: Bool

    var id: String { code }

    static let allBadges: [BadgeMeta] = [
        .init(
            code: "B001",
            name: "첫 입수", rewardDescription: "다이버시티에서의 첫 발견!",
            description: "첫 다이버를 등록했어요.\n당신의 탐험을 응원합니다.",
            condition: "첫 번째 다이버를 등록하면\n나의 탐험이 시작돼요.",
            imageName: "B001", isCollected: false
        ),
        .init(
            code: "B002",
            name: "수면 돌파", rewardDescription: "수면을 가르고 앞으로!",
            description: "벌써 10명의 다이버를 만났어요.\n수면 위의 세상이 눈 앞에!",
            condition: "10명의 다이버를 만나면,\n수면을 뚫고 깊은 곳으로 나아갑니다.",
            imageName: "B002", isCollected: false
        ),
        .init(
            code: "B003",
            name: "심해 탐험가", rewardDescription: "깊고 어두운 곳에서 만난 특별한 인연!",
            description: "깊고 어두운 심해 속,\n새로운 다이버를 찾아서 쑥~",
            condition: "20명의 다이버와 함께하며,\n심해 탐험가로 한 걸음 나아가요.",
            imageName: "B003", isCollected: false
        ),
        .init(
            code: "B004",
            name: "숨 고르기 마스터", rewardDescription: "잠깐 숨 돌리며, 나를 돌아보는 여정",
            description: "잠깐 숨 돌려요.\n여긴 중간 체크 포인트예요!",
            condition: "30명을 채우면,\n한 템포 쉬어가는 중간 지점에 도달해요.",
            imageName: "B004", isCollected: false
        ),
        .init(
            code: "B005",
            name: "다이버 콜렉터", rewardDescription: "나만의 다이버 컬렉션 완성 중!",
            description: "다양한 다이버들을 불러모았어요.\n다이버들은 많을수록 좋아요!",
            condition: "40명의 다이버를 불러모아,\n다채로운 탐험 일지를 채워보세요.",
            imageName: "B005", isCollected: false
        ),
        .init(
            code: "B006",
            name: "심해의 경계자", rewardDescription: "낯선 다이버들과의 조우, 경계선에 도달!",
            description: "드디어 위험한(?) 다이버들도\n 만나기 시작했군요...!",
            condition: "50명의 다이버를 만난 당신,\n이제 미지의 다이버들과도 조우할 시간이에요.",
            imageName: "B006", isCollected: false
        ),
        .init(
            code: "B007",
            name: "베테랑 다이버", rewardDescription: "파도에도 흔들림 없는 여유!",
            description: "산소가 부족해도 여유로운 당신,\n이제 진짜 프로예요",
            condition: "100명의 다이버를 만난 당신\n이제는 흔들림 없는 노련한 여정자예요.",
            imageName: "B007", isCollected: false
        ),
        .init(
            code: "B008",
            name: "레전드 다이버", rewardDescription: "전설을 완성했습니다",
            description: "전설의 다이버,\n모든 다이버를 빛내는 당신을 존경합니다!",
            condition: "모든 다이버를 수집하면,\n전설로 남을 여정이 완성됩니다.",
            imageName: "B008", isCollected: false
        )
    ]
}
