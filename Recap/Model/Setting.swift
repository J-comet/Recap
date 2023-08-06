//
//  Setting.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/06.
//

import Foundation

struct Setting {
    var type: SettingType
    var subTitle: String? = nil
}

enum SettingType {
    case name
    case tamagotchi
    case reset
}

extension SettingType {
    var title: String {
        get {
            switch self {
            case .name:
                return "내 이름 설정하기"
            case .tamagotchi:
                return "다마고치 변경하기"
            case .reset:
                return "데이터 초기화"
            }
        }
    }
    var imgName: String {
        get {
            switch self {
            case .name:
                return "pencil"
            case .tamagotchi:
                return "moon.fill"
            case .reset:
                return "arrow.clockwise"
            }
        }
    }
}
