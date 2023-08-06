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
        return [
            "잠이 오시나요?? \(name)님",
            "\(name)님 이 순간에도 누군가는 개발 중이랍니다.^^",
            "\(name)님 오늘 걸으면 내일은 달려야 합니다.",
            "영차영차! \(name)님 조금 더 힘내세요!",
            "\(name)...정신차려 이 각박한 세상속에서!",
            "\(name)님 집중이 안될 때는 산책 한걸음~ ^^",
            "언제나 길은 가능성을 향해 열려있어요. \(name)님",
            "\(name)님 하면 된다가 아니라 해야되요.",
            "\(name)님 이미 늦었다고 생각했을 때가 진짜 늦었어요.",
            "\(name).. 니가 선택한 iOS 다 악으로 깡으로 버텨라!!"
        ]
    }
}
