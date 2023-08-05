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
    
    var tamagotchi: Tamagotchi?

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
        print("시작")
    }
    
    
    func designVC() {
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        
        thumbImageView.contentMode = .scaleAspectFill
        
        nameStackView.layer.borderColor = MainColor.fontOrStroke.value.cgColor
        nameStackView.layer.cornerRadius = 6
        nameStackView.layer.borderWidth = 1
        nameStackView.clipsToBounds = true
        nameStackView.layoutMargins = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        nameStackView.isLayoutMarginsRelativeArrangement = true
        typeLabel.font = .boldSystemFont(ofSize: 13)
        typeLabel.textColor = MainColor.fontOrStroke.value
        baseLabel.font = .boldSystemFont(ofSize: 13)
        baseLabel.textColor = MainColor.fontOrStroke.value
        baseLabel.text = "다마고치"
        
        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.textAlignment = .center
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
        if let tamagotchi {
            typeLabel.text = tamagotchi.name.rawValue
            thumbImageView.image = UIImage(named: tamagotchi.imgName)
            contentLabel.text = tamagotchi.description.rawValue
        }
    }
    
    private func designBottomLabel(outlet label: UILabel) {
        label.font = .systemFont(ofSize: 16)
        label.textColor = MainColor.fontOrStroke.value
        label.textAlignment = .center
    }

}
