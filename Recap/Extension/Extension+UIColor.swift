//
//  Extensioni+UIColor.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/04.
//

import UIKit

enum MainColor {
    case background
    case fontOrStroke
    case setting
}

extension MainColor {
    var value: UIColor {
        switch self {
        case .background:
            return UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        case .fontOrStroke:
            return UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        case .setting:
            return UIColor(red: 69/255, green: 90/255, blue: 100/255, alpha: 1)
        }
    }
}
