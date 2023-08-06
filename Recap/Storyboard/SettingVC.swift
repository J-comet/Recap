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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designVC()
        configVC()
        configNavigationBar()
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonClicked)
        )
        navigationItem.leftBarButtonItem?.tintColor = MainColor.setting.value
                
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
    
    @objc func backButtonClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingInfo.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(row: SettingInfo.list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}