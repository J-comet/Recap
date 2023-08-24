//
//  UIViewController+Extension.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/13.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, msg: String, ok: String, no: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: ok, style: .default, handler: handler)
        alert.addAction(okAction)
        
        if let no {
            let noAction = UIAlertAction(title: no, style: .cancel)
            alert.addAction(noAction)
        }
        
        present(alert, animated: true)
    }
    
    func setBackgroundColor() {
        self.view.backgroundColor = MainColor.background.value
    }
    
    enum TransitionStyle {
        case present                      // 기본 present
        case prensentNavigation             // 네비바 임베디드 된 present
        case presentFulllNavigation         // 네비바 풀스크린, fullscreen present
        case presentOverFullScreen          // 네비바 오버 풀스크린
        case push
    }
    
    func transition<T: UIViewController>(viewController: T.Type, style: TransitionStyle, storyboard: String, animStyle: UIModalTransitionStyle = .coverVertical) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: String(describing: viewController)) as? T else { return }
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .prensentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalTransitionStyle = animStyle
            present(nav, animated: true)
        case .presentFulllNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = animStyle
            present(nav, animated: true)
        case .presentOverFullScreen:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalTransitionStyle = animStyle
            nav.modalPresentationStyle = .overFullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
}
