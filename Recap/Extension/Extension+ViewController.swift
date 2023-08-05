//
//  Extension+ViewController.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/05.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, msg: String, ok: String, no: String? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: ok, style: .default)
        alert.addAction(okAction)
        
        if let no {
            let noAction = UIAlertAction(title: no, style: .cancel)
            alert.addAction(noAction)
        }
        
        present(alert, animated: true)
    }
}
