//
//  TamagotchiRandomStory.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/06.
//

import Foundation

struct TamagotchiRandomStory {
    let name = UserDefaults.userInfo.name
    var list: [String] {
        return ["잠이 오시나요?? \(name)님", "\(name)님 이 순간에도 누군가는 개발 중이랍니다.^^", "\(name)님 오늘 걸으면 내일은 달려야 합니다.", "영차영차! \(name)님 조금 더 힘내세요!"]
    }
}
