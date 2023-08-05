//
//  MainVC.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/05.
//

import UIKit

enum FeedType: String {
    case rice = "밥주세용"
    case water = "물주세용"
}

class MainVC: UIViewController, BaseViewControllerProtocol {
    
    static var identifier = "MainVC"
    let userInfo = UserDefaults.userInfo
    
    @IBOutlet var navBarUnderLine: UIView!
    
    @IBOutlet var bottomDoneView: UIView!
    @IBOutlet var bottomDoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designVC()
        configVC()
        configNavigationBar()
    }
    
    func configNavigationBar() {
        title = "\(userInfo.name)님의 다마고치"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(settingButtonClicked)
        )
        navigationItem.rightBarButtonItem?.tintColor = MainColor.fontOrStroke.value
    }
    
    @objc func settingButtonClicked(_ sender: UIBarButtonItem) {
        print(#function)
    }
    
    func designVC() {
        setBackgroundColor()
        navBarUnderLine.backgroundColor = .systemGray5
    }
    
    func configVC() {
        
    }
    
    private func statusBottonDoneView(isHidden: Bool) {
        print("origin = ", self.bottomDoneView.frame.origin.y)
        print("height = ", self.bottomDoneView.frame.height)
        let height = self.bottomDoneView.frame.height
        let translationY: CGFloat = isHidden == true ? height : -height
        UIView.animate(withDuration: 0.7, delay: 0 , options: .curveEaseInOut, animations: {
            self.bottomDoneView.transform = CGAffineTransform(translationX: 0, y:  translationY)
        }, completion: nil)
    }
}
