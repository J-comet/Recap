//
//  SettingVC.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/06.
//

import UIKit

class SettingVC: UIViewController, BaseViewControllerProtocol {
    
    static var identifier = "SettingVC"
    
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
        let sb = UIStoryboard(name: StoryBoardId.Main.rawValue, bundle: nil)
        
        switch row.type {
        case .name:
            let vc = sb.instantiateViewController(withIdentifier: ChangeNameVC.identifier) as! ChangeNameVC
            navigationController?.pushViewController(vc, animated: true)
        case .tamagotchi:
            let vc = sb.instantiateViewController(withIdentifier: SelectTamagotchiVC.identifier) as! SelectTamagotchiVC
            navigationController?.pushViewController(vc, animated: true)
        case .reset:
            print("reset")
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}
