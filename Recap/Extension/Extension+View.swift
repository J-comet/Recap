//
//  Extension+View.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/05.
//

import UIKit

extension UILabel {
    func designTamagotchiName() {
        self.textColor = MainColor.fontOrStroke.value
        self.font = .boldSystemFont(ofSize: 13)
    }
}

extension UIStackView {
    func designTamagotchiNameBorderLine() {
        self.layer.borderColor = MainColor.fontOrStroke.value.cgColor
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.layoutMargins = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        self.isLayoutMarginsRelativeArrangement = true
    }
}

extension UITextField {
    func customUnderLine(color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height, width:  self.frame.size.width - 10, height: 1)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
