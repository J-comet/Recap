//
//  FeedButton.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/21.
//

import UIKit

@IBDesignable
class FeedButton: UIButton {
    
    @IBInspectable
    var corner: CGFloat {
        get {  return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
}
