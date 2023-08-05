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
    
    @IBOutlet var thumbImageView: UIImageView!
    
    @IBOutlet var nameStackView: UIStackView!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var baseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
    }
    
    func designCell() {
        nameStackView.layer.borderColor = MainColor.fontOrStroke.value.cgColor
        nameStackView.layer.cornerRadius = 6
        nameStackView.layer.borderWidth = 1
        nameStackView.clipsToBounds = true
        nameStackView.layoutMargins = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        nameStackView.isLayoutMarginsRelativeArrangement = true

        typeLabel.font = .boldSystemFont(ofSize: 12)
        typeLabel.textColor = MainColor.fontOrStroke.value
        baseLabel.font = .boldSystemFont(ofSize: 12)
        baseLabel.textColor = MainColor.fontOrStroke.value
        
        thumbImageView.contentMode = .scaleAspectFit
    }
    
    func configureCell(row: Tamagotchi) {
        if row.name == TamagotchiName.ready {
            baseLabel.isHidden = true
        } else {
            baseLabel.isHidden = false
        }
        typeLabel.text = row.name.rawValue
        thumbImageView.image = UIImage(named: row.imgName)
    }
}
