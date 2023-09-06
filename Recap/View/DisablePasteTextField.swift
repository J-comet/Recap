//
//  DisableCopyPasteTextField.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/16.
//

import UIKit

class DisablePasteTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
