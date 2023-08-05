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
    var imgName: String {
        return "\(type.rawValue)-\(level.rawValue)"
    }
}

enum TamagotchiName: String {
    case tingling = "따끔따끔"
    case fluttering = "방실방실"
    case twinkle = "반짝반짝"
    case ready = "준비중이에요"
}

enum TamagotchiDescription: String {
    case tingling = "저는 선인장 다마고치입니다. 키는 2cm 몸무게는 150g 이에요. 성격은 소심하지만 마음은 따뜻해요. 열심히 잘 먹고 잘 클 자신은 있답니다. 반가워요 주인님~:) "
    case fluttering = "저는 방실방실 다마고치입니당! 키는 100km 몸무게는 150톤이에용! 성격은 화끈하고 날라다닙니당! 열심히 잘 먹고 잘 클 자신은 있답니당! 방실방실! "
    case twinkle = "저는 반짝반짝 다마고치에요~ 키는 120cm 몸무게는 120g이에요~ 성격도 반짝반짝 시원시원 해요~ 저를 키워주세요~ 잘 먹고 잘 커볼게요~"
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
