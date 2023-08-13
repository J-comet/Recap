//
//  SettingTableViewCell.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/06.
//

import UIKit

class SettingTableViewCell: UITableViewCell, BaseCellProtocol {
    typealias T = Setting

    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
    }
    
    func designCell() {
        iconImageView.tintColor = MainColor.setting.value
        
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        subTitleLabel.textColor = .systemGray3
        subTitleLabel.font = .systemFont(ofSize: 12)
    }
    
    func configureCell(row: Setting) {
        iconImageView.image = UIImage(systemName: row.type.imgName)
        titleLabel.text = row.type.title
        subTitleLabel.text = row.subTitle
    }
}
