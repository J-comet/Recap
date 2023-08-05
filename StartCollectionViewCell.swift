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
    
    //    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nameButton: UIButton!
    @IBOutlet var thumbImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
    }
    
    func designCell() {
        nameButton.layer.borderColor = MainColor.fontOrStroke.value.cgColor
        nameButton.layer.cornerRadius = 6
        nameButton.layer.borderWidth = 1
        nameButton.clipsToBounds = true
        
        var config = UIButton.Configuration.filled()        // apple system button
        config.baseForegroundColor = MainColor.fontOrStroke.value
        config.baseBackgroundColor = MainColor.background.value
        config.titleAlignment = .center
        config.buttonSize = .mini
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)
        nameButton.configuration = config
        
        thumbImageView.contentMode = .scaleAspectFit
    }
    
    func configureCell(row: Tamagotchi) {
        if row.name == TamagotchiName.ready {
            nameButton.setTitle(row.name.rawValue, for: .normal)
        } else {
            nameButton.setTitle("\(row.name.rawValue) 다마고치", for: .normal)
        }
        
        thumbImageView.image = UIImage(named: row.imgName)
    }
}
