//
//  Tamagotchi.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/04.
//

import Foundation

struct Tamagotchi: Codable {
    
    var defaultImgName: String {
        return "\(type.rawValue)-6"
    }
    
    var type: TamagotchiType
    var rice = 0
    var water = 0
    var imgName: String {
        var imgLevel: Int
        if level == TamagotchiLevel.lv10 {
            imgLevel = 9
        } else {
            imgLevel = level.rawValue
        }
        return "\(type.rawValue)-\(imgLevel)"
    }
    var info: String {
        return "LV\(level.rawValue) · 밥알 \(rice)개 · 물방울 \(water)개"
    }
    var level: TamagotchiLevel {
        let sum = CGFloat((rice / 5) + (water / 2))
        let result = Int(sum / 10)
        print("레벨 = ", TamagotchiLevel(rawValue: result) ?? .lv1)
        return TamagotchiLevel(rawValue: result) ?? .lv1
    }
}

extension TamagotchiType {
    var name: String {
        switch self {
        case .tingling:
            return "따끔따끔"
        case .fluttering:
            return "방실방실"
        case .twinkle:
            return "반짝반짝"
        case .ready:
            return "준비중이에요"
        }
    }
    var description: String {
        switch self {
        case .tingling:
            return "저는 선인장 다마고치입니다. 키는 2cm 몸무게는 150g 이에요. 성격은 소심하지만 마음은 따뜻해요. 열심히 잘 먹고 잘 클 자신은 있답니다. 반가워요 주인님~:)"
        case .fluttering:
            return "저는 방실방실 다마고치입니당! 키는 100km 몸무게는 150톤이에용! 성격은 화끈하고 날라다닙니당! 열심히 잘 먹고 잘 클 자신은 있답니당! 방실방실!"
        case .twinkle:
            return "저는 반짝반짝 다마고치에요~ 키는 120cm 몸무게는 120g이에요~ 성격도 반짝반짝 시원시원 해요~ 저를 키워주세요~ 잘 먹고 잘 커볼게요~"
        case .ready:
            return ""
        }
    }
}

enum TamagotchiType: Int, Codable  {
    case tingling = 1
    case fluttering
    case twinkle
    case ready
}

enum TamagotchiLevel: Int, Codable {
    case lv1 = 1
    case lv2
    case lv3
    case lv4
    case lv5
    case lv6
    case lv7
    case lv8
    case lv9
    case lv10
}
