//
//  SettingVC.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/06.
//

import UIKit

class SettingVC: UIViewController, BaseViewControllerProtocol {
    
    @IBOutlet var settingTableView: UITableView!
    
    var list: [Setting] = [] {
        didSet {
            settingTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designVC()
        configVC()
        configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        list = SettingInfo().list
    }

    func designVC() {
        settingTableView.rowHeight = 60
        settingTableView.separatorStyle = .singleLine
        settingTableView.bounces = false
    }
    
    func configVC() {
        settingTableView.dataSource = self
        settingTableView.delegate = self
        
        let tableNib = UINib(nibName: SettingTableViewCell.identifier, bundle: nil)
        settingTableView.register(tableNib, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
    
    func configNavigationBar() {
        title = "설정"
        
        self.navigationController?.navigationBar.tintColor = MainColor.setting.value
  
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        let titleAttribute = [
            NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 16, weight: .semibold),
            NSAttributedString.Key.foregroundColor: MainColor.setting.value
        ]
        appearance.titleTextAttributes = titleAttribute
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(row: list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = list[indexPath.row]
        
        switch row.type {
        case .name:
            self.transition(viewController: ChangeNameVC.self, style: .push, storyboard: StoryBoardId.Main.rawValue)
        case .tamagotchi:
            self.transition(viewController: SelectTamagotchiVC.self, style: .push, storyboard: StoryBoardId.Main.rawValue)
        case .reset:
            showAlert(title: "데이터 초기화", msg: "정말 다시 처음부터 시작하실 건가용?", ok: "웅", no: "아냐!") {(action) in
                UserDefaults.userInfo = UserInfo(name: "대장", tamagotchi: nil)
                
                self.transition(
                    viewController: SelectTamagotchiVC.self,
                    style: .presentFulllNavigation,
                    storyboard: StoryBoardId.Main.rawValue,
                    animStyle: .crossDissolve
                )
            }
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}
