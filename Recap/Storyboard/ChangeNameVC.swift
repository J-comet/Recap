//
//  ChangeNameVC.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/06.
//

import UIKit

class ChangeNameVC: UIViewController, BaseViewControllerProtocol {
    
    @IBOutlet var nameTextField: UITextField!
    
    enum SaveNameError: Error {
        case emptyString
        case limit
    }
    
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
        do {
            let _ = try checkNameInput(text: inputText)
            UserDefaults.userInfo.name = inputText
            
            // 노티피케이션으로 값 전달
            NotificationCenter.default.post(
                name: NSNotification.Name(NotificationName.changeName.rawValue),
                object: nil,
                userInfo: ["nickname": inputText]
            )
            
            navigationController?.popViewController(animated: true)
        } catch SaveNameError.emptyString {
            showAlert(title: "이름", msg: "이름을 입력해주세요", ok: "확인")
        } catch {
            showAlert(title: "이름", msg: "2글자에서 6글자이하로 입력해주세요", ok: "확인")
        }
    }
    
    private func checkNameInput(text: String) throws -> Bool {
        guard !(text.isEmpty) else {
            throw SaveNameError.emptyString
        }
        
        guard 1 < text.count && text.count < 7 else {
            throw SaveNameError.limit
        }
        
        return true
    }
}

extension ChangeNameVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveUserName(inputText: textField.text!)
        return true
    }
}
