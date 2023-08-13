//
//  UILabel+Extension.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/13.
//

import UIKit

extension UILabel {
    func designTamagotchiName() {
        self.textColor = MainColor.fontOrStroke.value
        self.font = .boldSystemFont(ofSize: 13)
    }
}
