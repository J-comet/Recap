//
//  Tamagotchi.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/04.
//

import Foundation

struct Tamagotchi {
    var type: TamagotchiType
    var name: TamagotchiName
    var description: TamagotchiDescription
    var level: TamagotchiLevel
    var rice: Int
    var water: Int
}

enum TamagotchiName: String {
    case tingling = "따끔따끔"
    case fluttering = "방실방실"
    case twinkle = "반짝반짝"
    case ready = "준비중이에요"
}

enum TamagotchiDescription: String {
    case tingling = "따끔따끔 설명"
    case fluttering = "방실방실 설명"
    case twinkle = "반짝반짝 설명"
}

enum TamagotchiType: Int  {
    case tingling = 1
    case fluttering
    case twinkle
    case ready
}

enum TamagotchiLevel: Int {
    case lv1 = 1
    case lv2
    case lv3
    case lv4
    case lv5
    case lv6
    case lv7
    case lv8
    case lv9
}
