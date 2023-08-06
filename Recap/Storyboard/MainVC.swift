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
    
    @IBOutlet var bottomDoneView: UIView!
    @IBOutlet var bottomDoneLabel: UILabel!
    @IBOutlet var bottomDoneButton: UIButton!
    
    @IBOutlet var bubbleImageView: UIImageView!
    @IBOutlet var tamagotchiImageView: UIImageView!
    @IBOutlet var randomContentLabel: UILabel!
    
    @IBOutlet var nameStackView: UIStackView!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var baseLabel: UILabel!
    
    @IBOutlet var tamagotchiInfoLabel: UILabel!
    
    @IBOutlet var riceButton: UIButton!
    @IBOutlet var riceTextField: UITextField!
    
    @IBOutlet var waterButton: UIButton!
    @IBOutlet var waterTextField: UITextField!

    let randomStoryList = TamagotchiRandomStory().list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designVC()
        configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        randomContentLabel.text = randomStoryList.randomElement()!
        configVC()
    }
    
    @objc func settingButtonClicked(_ sender: UIBarButtonItem) {
        print(#function)
    }
    
//    @IBAction func bottomDoneClicked(_ sender: UIButton) {
//        statusBottonDoneView(isHidden: true)
//    }
    
    @IBAction func viewTabGestureTabbed(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func configNavigationBar() {
        title = "\(UserDefaults.userInfo.name)님의 다마고치"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(settingButtonClicked)
        )
        navigationItem.rightBarButtonItem?.tintColor = MainColor.fontOrStroke.value

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func designVC() {
        setBackgroundColor()
        
//        designBottomDoneView()
        designMainContentView()
        designButton(outlet: riceButton, title: "밥먹기", imgName: "drop.circle")
        designButton(outlet: waterButton, title: "물먹기", imgName: "leaf.circle")
        designTextField(outlet: riceTextField, placeHolder: FeedType.rice.rawValue)
        designTextField(outlet: waterTextField, placeHolder: FeedType.water.rawValue)
    }
    
    func configVC() {
        
        guard let tamagotchi = UserDefaults.userInfo.tamagotchi else {
            print("오류!!!")
            return
        }
        
        tamagotchiImageView.image = UIImage(named: tamagotchi.imgName)
        tamagotchiInfoLabel.text = "LV\(tamagotchi.level.rawValue) · 밥알 \(tamagotchi.rice)개 · 물방울 \(tamagotchi.water)개"
        typeLabel.text = tamagotchi.name.rawValue
    }
    
    /**
     * IQKeyboardManager 적용 후 애니매이션 및 디자인 주석처리
     */
//    private func statusBottonDoneView(isHidden: Bool) {
//        print("origin = ", self.bottomDoneView.frame.origin.y)
//        print("height = ", self.bottomDoneView.frame.height)
//        let height = self.bottomDoneView.frame.height
//        let translationY: CGFloat = isHidden == true ? height : -height
//        UIView.animate(withDuration: 0.7, delay: 0 , options: .curveEaseInOut, animations: {
//            self.bottomDoneView.transform = CGAffineTransform(translationX: 0, y:  translationY)
//        }, completion: nil)
//    }
//    private func designBottomDoneView() {
//        bottomDoneLabel.text = FeedType.rice.rawValue
//        bottomDoneLabel.font = .systemFont(ofSize: 12)
//        bottomDoneLabel.textColor = .systemGray3
//
//        bottomDoneButton.setTitle("Done", for: .normal)
//        bottomDoneButton.tintColor = .link
//        bottomDoneButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
//    }
    
    private func designMainContentView() {
        bubbleImageView.image = UIImage(named: "bubble")
        bubbleImageView.contentMode = .scaleToFill
        tamagotchiImageView.contentMode = .scaleAspectFit
        
        randomContentLabel.font = .systemFont(ofSize: 15)
        randomContentLabel.textColor = .darkGray
        randomContentLabel.numberOfLines = 0
        randomContentLabel.lineBreakMode = .byWordWrapping
        
        nameStackView.designTamagotchiNameBorderLine()
        typeLabel.designTamagotchiName()
        baseLabel.designTamagotchiName()
        
        tamagotchiInfoLabel.font = .boldSystemFont(ofSize: 15)
        tamagotchiInfoLabel.textColor = .darkGray
        tamagotchiInfoLabel.textAlignment = .center
    }
    
    private func designButton(outlet button: UIButton, title: String, imgName: String) {
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = MainColor.fontOrStroke.value.cgColor
        
        var attString = AttributedString(title)
        attString.font = .systemFont(ofSize: 14, weight: .medium)
        attString.foregroundColor = MainColor.fontOrStroke.value
        var config = UIButton.Configuration.filled()
        config.attributedTitle = attString
        config.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        config.image = UIImage(systemName: imgName)
        config.imagePadding = 4
        config.imagePlacement = .leading
        config.baseBackgroundColor = MainColor.background.value
        config.baseForegroundColor = MainColor.fontOrStroke.value
        button.configuration = config
    }
    
    private func designTextField(outlet textField: UITextField, placeHolder: String) {
        textField.placeholder = placeHolder
        textField.borderStyle = .none
        textField.textAlignment = .center
        textField.customUnderLine(color: .black)
        textField.keyboardType = .numbersAndPunctuation
        textField.returnKeyType = .done
    }
    
}
