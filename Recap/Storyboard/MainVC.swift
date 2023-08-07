//
//  MainVC.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/05.
//

import UIKit

enum FeedType {
    case rice
    case water
}

extension FeedType {
    var buttonTitle: String {
        switch self {
        case .rice:
            return "밥먹기"
        case .water:
            return "물먹기"
        }
    }
    
    var placeText: String {
        switch self {
        case .rice:
            return "밥주세용"
        case .water:
            return "물주세용"
        }
    }
    
    var img: String {
        switch self {
        case .rice:
            return "leaf.circle"
        case .water:
            return "drop.circle"
        }
    }
    
    var errorMsg: String {
        switch self {
        case .rice:
            return "밥은 99개까지 먹일 수 있어요"
        case .water:
            return "물은 49개까지 먹일 수 있어요"
        }
    }
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
    
    var selectedTamagotchi: Tamagotchi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designVC()
        configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateRandomStory()
        
        title = "\(UserDefaults.userInfo.name)님의 다마고치"
        configVC()
    }
    
    override func awakeAfter(using coder: NSCoder) -> Any? {
        navigationItem.backButtonDisplayMode = .minimal
        return super.awakeAfter(using: coder)
    }
    
    @objc func settingButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: StoryBoardId.Main.rawValue, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SettingVC.identifier) as! SettingVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //    @IBAction func bottomDoneClicked(_ sender: UIButton) {
    //        statusBottonDoneView(isHidden: true)
    //    }
    
    @IBAction func viewTabGestureTabbed(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func riceButtonClicked(_ sender: UIButton) {
        if selectedTamagotchi != nil {
            if riceTextField.text?.count ?? 0 > 0 {
                let input = Int(riceTextField.text!) ?? 0
                if input > 99 {
                    showAlert(title: "경고", msg: FeedType.rice.errorMsg, ok: "확인")
                    riceTextField.text = nil
                    return
                } else {
                    selectedTamagotchi!.rice += Int(riceTextField.text!) ?? 0
                    tamagotchiInfoLabel.text = selectedTamagotchi?.info
                    riceTextField.text = nil
                }
            } else {
                selectedTamagotchi!.rice += 1
                tamagotchiInfoLabel.text = selectedTamagotchi?.info
            }
            
            updateRandomStory()
            UserDefaults.userInfo.tamagotchi = selectedTamagotchi
            tamagotchiImageView.image = UIImage(named: selectedTamagotchi!.imgName)
        }
    }
    
    @IBAction func waterButtonClicked(_ sender: UIButton) {
        if selectedTamagotchi != nil {
            if waterTextField.text?.count ?? 0 > 0 {
                let input = Int(waterTextField.text!) ?? 0
                if input > 49 {
                    showAlert(title: "경고", msg: FeedType.water.errorMsg, ok: "확인")
                    waterTextField.text = nil
                    return
                } else {
                    selectedTamagotchi!.water += Int(waterTextField.text!) ?? 0
                    tamagotchiInfoLabel.text = selectedTamagotchi?.info
                    waterTextField.text = nil
                }
            } else {
                selectedTamagotchi!.water += 1
                tamagotchiInfoLabel.text = selectedTamagotchi?.info
            }
            
            updateRandomStory()
            UserDefaults.userInfo.tamagotchi = selectedTamagotchi
            tamagotchiImageView.image = UIImage(named: selectedTamagotchi!.imgName)
        }
    }
    
    func configNavigationBar() {
        
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
    
    private func updateRandomStory() {
        randomContentLabel.text = TamagotchiRandomStory().list.randomElement()!
    }
    
    func designVC() {
        setBackgroundColor()
        
        //        designBottomDoneView()
        designMainContentView()
        designButton(outlet: riceButton, type: FeedType.rice)
        designButton(outlet: waterButton, type: FeedType.water)
        designTextField(outlet: riceTextField, placeHolder: FeedType.rice.placeText)
        designTextField(outlet: waterTextField, placeHolder: FeedType.water.placeText)
    }
    
    func configVC() {
        let currentTama = currentTamagotchi(selectedTama: selectedTamagotchi)
        guard let currentTama else {
            print("다마고치 nil")
            return
        }
        tamagotchiImageView.image = UIImage(named: currentTama.imgName)
        tamagotchiInfoLabel.text = currentTama.info
        typeLabel.text = currentTama.type.name
        
        selectedTamagotchi = currentTama
    }
    
    private func currentTamagotchi(selectedTama: Tamagotchi?) -> Tamagotchi? {
        guard let selectedTama else {
            print("전달 받은 데이터 없음!!")
            return UserDefaults.userInfo.tamagotchi
        }
        return selectedTama
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
    
    private func designButton(outlet button: UIButton, type: FeedType) {
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = MainColor.fontOrStroke.value.cgColor
        
        var attString = AttributedString(type.buttonTitle)
        attString.font = .systemFont(ofSize: 14, weight: .medium)
        attString.foregroundColor = MainColor.fontOrStroke.value
        var config = UIButton.Configuration.filled()
        config.attributedTitle = attString
        config.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        config.image = UIImage(systemName: type.img)
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
        textField.keyboardType = .numberPad
        textField.returnKeyType = .done
    }
    
}
