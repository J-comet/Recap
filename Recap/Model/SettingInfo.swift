//
//  SettingInfo.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/06.
//

import Foundation

struct SettingInfo {
    let list: [Setting] = [
        Setting(type: .name, subTitle: "\(UserDefaults.userInfo.name)"),
        Setting(type: .tamagotchi),
        Setting(type: .reset)
    ]
}
