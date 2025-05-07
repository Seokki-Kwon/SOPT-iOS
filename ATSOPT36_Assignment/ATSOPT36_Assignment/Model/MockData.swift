//
//  MockData.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/2/25.
//

import UIKit

enum MockData {
    case thumbnail
    case banner
    case todayTving([ContentModel])
    case popularLive([ContentModel])
    case popularMovie([ContentModel])
    case sport([ContentModel])
    case kimGahyunBest([ContentModel])
}

extension MockData {
    static let items: [Self] = [
        .thumbnail,
        .todayTving([
            .init(title: "", description: "", rating: 10.0, thumbnail: UIImage(resource: .movie1)),
            .init(title: "", description: "", rating: 9.0, thumbnail: UIImage(resource: .movie2)),
            .init(title: "", description: "", rating: 8.0, thumbnail: UIImage(resource: .movie3)),
            .init(title: "", description: "", rating: 7.0, thumbnail: UIImage(resource: .movie4)),
            .init(title: "", description: "", rating: 6.0, thumbnail: UIImage(resource: .movie5))
        ]),
        .popularLive([
            .init(title: "놀면 뭐하니?", description: "유재석과 다양한 출연자들이 펼치는 리얼 버라이어티 예능", rating: 8.7, thumbnail: UIImage(resource: .poupluar1)),
            .init(title: "런닝맨", description: "국내외 팬들에게 꾸준히 사랑받는 추격 예능", rating: 8.5, thumbnail: UIImage(resource: .poupluar2)),
            .init(title: "1박 2일", description: "멤버들이 전국 각지를 여행하며 펼치는 예능", rating: 8.3, thumbnail: UIImage(resource: .poupluar3)),
            .init(title: "서울의 봄", description: "대한민국 근현대사의 한복판을 그린 정치 스릴러", rating: 9.0, thumbnail: UIImage(resource: .poupluar4)),
            .init(title: "서울의 봄", description: "대한민국 근현대사의 한복판을 그린 정치 스릴러", rating: 9.0, thumbnail: UIImage(resource: .poupluar5)),
        ]),
        .popularMovie([
            .init(title: "범죄도시4", description: "마석도 형사의 통쾌한 범죄 소탕 작전", rating: 9.1, thumbnail: UIImage(resource: .movie1)),
            .init(title: "귀공자", description: "죽음의 추격을 피해 도망치는 남자의 이야기", rating: 8.8, thumbnail: UIImage(resource: .movie2)),
            .init(title: "서울의 봄", description: "대한민국 근현대사의 한복판을 그린 정치 스릴러", rating: 9.0, thumbnail: UIImage(resource: .movie3)),
            .init(title: "서울의 봄", description: "대한민국 근현대사의 한복판을 그린 정치 스릴러", rating: 9.0, thumbnail: UIImage(resource: .movie4)),
            .init(title: "서울의 봄", description: "대한민국 근현대사의 한복판을 그린 정치 스릴러", rating: 9.0, thumbnail: UIImage(resource: .movie5)),
        ]),
        .banner,
        .sport([
            .init(title: "2025 KBO 리그", description: "한국 프로야구 시즌 생중계", rating: 8.9, thumbnail: UIImage(resource: .sprot1)),
            .init(title: "UCL 2024-25", description: "유럽 챔피언스리그 하이라이트와 생중계", rating: 9.4, thumbnail: UIImage(resource: .sport2)),
            .init(title: "UCL 2024-25", description: "유럽 챔피언스리그 하이라이트와 생중계", rating: 9.4, thumbnail: UIImage(resource: .sport3)),
            .init(title: "UCL 2024-25", description: "유럽 챔피언스리그 하이라이트와 생중계", rating: 9.4, thumbnail: UIImage(resource: .sport4)),
        ]),
        .kimGahyunBest([
            .init(title: "눈물의 여왕", description: "재벌가 부부의 위기와 사랑을 그린 감성 드라마", rating: 9.5, thumbnail: UIImage(resource: .kimgahyun1)),
            .init(title: "이두나!", description: "아이돌과 대학생의 특별한 동거 이야기", rating: 8.6, thumbnail: UIImage(resource: .kimgahyun2)),
            .init(title: "무빙", description: "초능력을 지닌 가족들의 비밀스러운 이야기", rating: 9.2, thumbnail: UIImage(resource: .kimgahyun3)),
            .init(title: "무빙", description: "초능력을 지닌 가족들의 비밀스러운 이야기", rating: 9.2, thumbnail: UIImage(resource: .kimgahyun4)),
            .init(title: "무빙", description: "초능력을 지닌 가족들의 비밀스러운 이야기", rating: 9.2, thumbnail: UIImage(resource: .kimgahyun5)),
        ])
    ]   
}
