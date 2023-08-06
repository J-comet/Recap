//
//  ChangeNameVC.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/06.
//

import UIKit

class ChangeNameVC: UIViewController, BaseViewControllerProtocol {
    
    static var identifier = "ChangeNameVC"
    
    @IBOutlet var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designVC()
        configVC()
        configNavigationBar()
        setBackgroundColor()
    }
    
    @IBAction func containerViewTabbed(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func designVC() {
        nameTextField.placeholder = "대장님 이름을 알려주세요!"
        nameTextField.customUnderLine(color: .black)
        nameTextField.borderStyle = .none
        nameTextField.keyboardType = .namePhonePad
        nameTextField.returnKeyType = .done
    }
    
    func configVC() {
        nameTextField.delegate = self
        nameTextField.text = UserDefaults.userInfo.name
    }
    
    func configNavigationBar() {
        title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = MainColor.setting.value
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        let titleAttribute = [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 16, weight: .semibold), NSAttributedString.Key.foregroundColor: MainColor.setting.value]
        appearance.titleTextAttributes = titleAttribute
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func saveButtonClicked(_ sender: UIBarButtonItem) {
        saveUserName(inputText: nameTextField.text!)
    }
    
    private func saveUserName(inputText: String) {
        switch inputText.count {
        case 0:
            showAlert(title: "", msg: "이름을 입력해주세요", ok: "확인")
        case 2...6:
            UserDefaults.userInfo.name = inputText
            navigationController?.popViewController(animated: true)
        default:
            showAlert(title: "", msg: "2글자에서 6글자이하로 입력해주세요", ok: "확인")
        }
    }
}

extension ChangeNameVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveUserName(inputText: textField.text!)
        return true
    }
}
