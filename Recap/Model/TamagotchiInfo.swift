//
//  TamagotchiInfo.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/05.
//

import Foundation

struct TamagotchiInfo {

    func getList() -> [Tamagotchi] {
        var list: [Tamagotchi] = []
        for i in 0..<30 {
            var tamagotchi: Tamagotchi
            switch i {
            case 0:
                tamagotchi = Tamagotchi(type: .tingling, name: .tingling, description: .tingling, level: .lv6)
            case 1:
                tamagotchi = Tamagotchi(type: .fluttering, name: .fluttering, description: .fluttering, level: .lv6)
            case 2:
                tamagotchi = Tamagotchi(type: .twinkle, name: .twinkle, description: .twinkle, level: .lv6)
            default:
                tamagotchi = Tamagotchi(type: .ready, name: .ready, description: .ready, level: .lv1)
            }
            list.append(tamagotchi)
        }
        return list
    }
}
