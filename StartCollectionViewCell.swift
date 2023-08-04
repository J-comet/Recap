//
//  StartCollectionViewCell.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/04.
//

import UIKit

class StartCollectionViewCell: UICollectionViewCell, BaseCollectionViewCellProtocol {
    
    typealias T = Tamagotchi
    static var identifier = "StartCollectionViewCell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var thumbImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
    }

    func designCell() {
        nameLabel.font = .boldSystemFont(ofSize: 13)
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        nameLabel.layer.cornerRadius = 8
        nameLabel.layer.borderWidth = 2
        nameLabel.layer.borderColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1).cgColor
        nameLabel.clipsToBounds = true
    }
    
    func configureCell(row: Tamagotchi) {
        nameLabel.text = row.name.rawValue
        
        // ex) "1-1", "1-2"
        thumbImageView.image = UIImage(named: "1-1")
    }
}
