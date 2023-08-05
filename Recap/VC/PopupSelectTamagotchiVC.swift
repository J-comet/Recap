//
//  PopupSelectTamagotchiVC.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/05.
//

import UIKit

class PopupSelectTamagotchiVC: UIViewController, BaseViewControllerProtocol {
    
    static var identifier = "PopupSelectTamagotchiVC"
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var thumbImageView: UIImageView!
    
    @IBOutlet var nameStackView: UIStackView!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var baseLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    @IBOutlet var cancelLabel: UILabel!
    @IBOutlet var startLabel: UILabel!
    
    var selectedTamagotchi: Tamagotchi?

    override func viewDidLoad() {
        super.viewDidLoad()
        designVC()
        configVC()
        
        cancelLabel.isUserInteractionEnabled = true
        startLabel.isUserInteractionEnabled = true
    }
    
    @IBAction func cancelClicked(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @IBAction func startClicked(_ sender: UITapGestureRecognizer) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: StoryBoardId.Main.rawValue, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: MainVC.identifier) as? MainVC else {
            return
        }
        
        selectedTamagotchi?.level = .lv1
        
        UserDefaults.userInfo = UserInfo(tamagotchi: selectedTamagotchi)
        
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.makeKeyAndVisible()
        
        // 데이터 저장 완료 메인 화면 개발 시작
    }
    
    
    func designVC() {
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        containerView.backgroundColor = MainColor.background.value
        
        thumbImageView.contentMode = .scaleAspectFill
        
        nameStackView.designTamagotchiNameBorderLine()
        typeLabel.designTamagotchiName()
        baseLabel.designTamagotchiName()
        
        baseLabel.text = "다마고치"
        
        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.textAlignment = .center
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.numberOfLines = 0
        contentLabel.textColor = MainColor.fontOrStroke.value
//        contentLabel.sizeToFit()
        
        cancelLabel.text = "취소"
        cancelLabel.backgroundColor = .systemGray6
        startLabel.text = "시작하기"
        designBottomLabel(outlet: cancelLabel)
        designBottomLabel(outlet: startLabel)
    }
    
    func configVC() {
        if let selectedTamagotchi {
            typeLabel.text = selectedTamagotchi.name.rawValue
            thumbImageView.image = UIImage(named: selectedTamagotchi.imgName)
            contentLabel.text = selectedTamagotchi.description.rawValue
        }
    }
    
    private func designBottomLabel(outlet label: UILabel) {
        label.font = .systemFont(ofSize: 16)
        label.textColor = MainColor.fontOrStroke.value
        label.textAlignment = .center
    }

}
