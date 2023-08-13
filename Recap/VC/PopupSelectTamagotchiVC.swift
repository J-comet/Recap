//
//  PopupSelectTamagotchiVC.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/05.
//

import UIKit

class PopupSelectTamagotchiVC: UIViewController, BaseViewControllerProtocol {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var thumbImageView: UIImageView!
    
    @IBOutlet var nameStackView: UIStackView!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var baseLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    @IBOutlet var cancelLabel: UILabel!
    @IBOutlet var okLabel: UILabel!
    
    var selectedTamagotchi: Tamagotchi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designVC()
        configVC()
        
        cancelLabel.isUserInteractionEnabled = true
        okLabel.isUserInteractionEnabled = true
    }
    
    @IBAction func cancelClicked(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
    
    @IBAction func startClicked(_ sender: UITapGestureRecognizer) {
        moveMainVC()
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
        okLabel.text = UserDefaults.userInfo.tamagotchi == nil ? "시작하기" : "변경하기"
        designBottomLabel(outlet: cancelLabel)
        designBottomLabel(outlet: okLabel)
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
    
    private func moveMainVC() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: StoryBoardId.Main.rawValue, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: MainVC.identifier) as? MainVC else {
            return
        }
        
        // 처음 시작유저
        if UserDefaults.userInfo.tamagotchi == nil {
            UserDefaults.userInfo.tamagotchi = selectedTamagotchi
            vc.selectedTamagotchi = selectedTamagotchi
        } else {
            // 다마고치 변경하기
            guard let _ = UserDefaults.userInfo.tamagotchi, let selectedTamagotchi else {
                showAlert(title: "", msg: "앱을 재실행 해주세요", ok: "확인")
                return
            }
            UserDefaults.userInfo.tamagotchi!.type = selectedTamagotchi.type
        }
        
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
}
