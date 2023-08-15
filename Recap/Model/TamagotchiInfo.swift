//
//  TamagotchiInfo.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/05.
//

import Foundation

enum TamagotchiInfo {

    static func getList() -> [Tamagotchi] {
        var list: [Tamagotchi] = []
        for i in 0..<30 {
            var tamagotchi: Tamagotchi
            switch i {
            case 0:
                tamagotchi = Tamagotchi(type: .tingling)
            case 1:
                tamagotchi = Tamagotchi(type: .fluttering)
            case 2:
                tamagotchi = Tamagotchi(type: .twinkle)
            default:
                tamagotchi = Tamagotchi(type: .ready)
            }
            list.append(tamagotchi)
        }
        return list
    }
}
