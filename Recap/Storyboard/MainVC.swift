//
//  MainVC.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/05.
//

import UIKit

class MainVC: UIViewController, BaseViewControllerProtocol {
    
    enum GrothError: Error {
        case emptyTamagotchi
        case isNotInt
        case overLimit
    }
    
    enum FeedType {
        case rice
        case water
    }
    
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
        title = "\(UserDefaults.userInfo.name)님의 다마고치"
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeNicknameNotificationObserver),
            name: NSNotification.Name(NotificationName.changeName.rawValue),
            object: nil
        )
    }
    
    @objc
    func changeNicknameNotificationObserver(notification: NSNotification) {
        if let nickname = notification.userInfo?["nickname"] as? String {
            title = "\(nickname)님의 다마고치"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateRandomStory()
        
//        title = "\(UserDefaults.userInfo.name)님의 다마고치"
        configVC()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    override func awakeAfter(using coder: NSCoder) -> Any? {
        navigationItem.backButtonDisplayMode = .minimal
        return super.awakeAfter(using: coder)
    }
    
    @objc func settingButtonClicked(_ sender: UIBarButtonItem) {
//        NotificationManager.shared.pushTest()
        transition(viewController: SettingVC.self, style: .push, storyboard: StoryBoardId.Main.rawValue)
    }
    
    //    @IBAction func bottomDoneClicked(_ sender: UIButton) {
    //        statusBottonDoneView(isHidden: true)
    //    }
    
    @IBAction func viewTabGestureTabbed(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func riceButtonClicked(_ sender: UIButton) {
        if riceTextField.text!.isEmpty {
            selectedTamagotchi!.rice += 1
            tamagotchiInfoLabel.text = selectedTamagotchi?.info
        } else {
            do {
                let _ = try checkGrothInput(tamagotchi: selectedTamagotchi, input: riceTextField.text!, type: .rice)
                selectedTamagotchi!.rice += Int(riceTextField.text!) ?? 0
                tamagotchiInfoLabel.text = selectedTamagotchi?.info
                riceTextField.text = nil
            } catch GrothError.emptyTamagotchi {
                showAlert(title: "오류", msg: "다마고치 정보가 없어요", ok: "확인")
            } catch {
                showAlert(title: "경고", msg: FeedType.rice.errorMsg, ok: "확인")
                riceTextField.text = nil
            }
        }
        updateRandomStory()
        UserDefaults.userInfo.tamagotchi = selectedTamagotchi
        tamagotchiImageView.image = UIImage(named: selectedTamagotchi!.imgName)
    }
    
    @IBAction func waterButtonClicked(_ sender: UIButton) {
        if waterTextField.text!.isEmpty {
            selectedTamagotchi!.water += 1
            tamagotchiInfoLabel.text = selectedTamagotchi?.info
        } else {
            do {
                let _ = try checkGrothInput(tamagotchi: selectedTamagotchi, input: waterTextField.text!, type: .water)
                selectedTamagotchi!.water += Int(waterTextField.text!) ?? 0
                tamagotchiInfoLabel.text = selectedTamagotchi?.info
                waterTextField.text = nil
            } catch GrothError.emptyTamagotchi {
                showAlert(title: "오류", msg: "다마고치 정보가 없어요", ok: "확인")
            } catch {
                showAlert(title: "경고", msg: FeedType.water.errorMsg, ok: "확인")
                waterTextField.text = nil
            }
        }
        updateRandomStory()
        UserDefaults.userInfo.tamagotchi = selectedTamagotchi
        tamagotchiImageView.image = UIImage(named: selectedTamagotchi!.imgName)
    }
    
    // 밥먹기, 물먹기 error 핸들링
    func checkGrothInput(tamagotchi: Tamagotchi?, input: String, type: FeedType) throws -> Bool {
        guard tamagotchi != nil else {
            throw GrothError.emptyTamagotchi
        }
        guard Int(input) != nil else {
            throw GrothError.isNotInt
        }
        
        switch type {
        case .rice:
            guard Int(input) ?? 0 < 100 else {
                throw GrothError.overLimit
            }
        case .water:
            guard Int(input) ?? 0 < 50 else {
                throw GrothError.overLimit
            }
        }
        return true
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
//        button.layer.cornerRadius = 8
//        button.layer.borderWidth = 1
//        button.layer.borderColor = MainColor.fontOrStroke.value.cgColor
        
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

extension MainVC.FeedType {
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
