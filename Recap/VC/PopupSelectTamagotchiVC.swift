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
    @IBOutlet var changeLabel: UILabel!
    
    var selectedTamagotchi: Tamagotchi?

    override func viewDidLoad() {
        super.viewDidLoad()
        designVC()
        configVC()
        
        cancelLabel.isUserInteractionEnabled = true
        startLabel.isUserInteractionEnabled = true
        changeLabel.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startLabel.isHidden = UserDefaults.userInfo.tamagotchi == nil ? false : true
        changeLabel.isHidden = UserDefaults.userInfo.tamagotchi == nil ? true : false
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
        
        UserDefaults.userInfo = UserInfo(tamagotchi: selectedTamagotchi)
        vc.selectedTamagotchi = selectedTamagotchi
        
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @IBAction func changeClicked(_ sender: UITapGestureRecognizer) {
        // 변경버튼 누를 시 모든 스택 날리고 MainVC 로 이동
        
        guard let selectedTamagotchi else {
            showAlert(title: "", msg: "앱을 재실행해주세요", ok: "확인")
            return
        }
        
        UserDefaults.userInfo.tamagotchi?.type = selectedTamagotchi.type
        
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
        
        
        cancelLabel.backgroundColor = .systemGray6
        cancelLabel.text = "취소"
        startLabel.text = "시작하기"
        changeLabel.text = "변경하기"
        designBottomLabel(outlet: cancelLabel)
        designBottomLabel(outlet: startLabel)
        designBottomLabel(outlet: changeLabel)
    }
    
    func configVC() {
        if let selectedTamagotchi {
            typeLabel.text = selectedTamagotchi.type.name
            thumbImageView.image = UIImage(named: selectedTamagotchi.defaultImgName)
            contentLabel.text = selectedTamagotchi.type.description
        }
    }
    
    private func designBottomLabel(outlet label: UILabel) {
        label.font = .systemFont(ofSize: 16)
        label.textColor = MainColor.fontOrStroke.value
        label.textAlignment = .center
    }

}
