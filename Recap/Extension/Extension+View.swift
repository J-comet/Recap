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
    // iPhone 14 Pro Max 가로 스택뷰 안에서 trailling 라인 다 보이지 않는 이슈=
//    func customUnderLine(color: UIColor) {
//        self.borderStyle = .none
//        let border = CALayer()
//        border.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 1)
//        border.backgroundColor = color.cgColor
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
//    }
}
