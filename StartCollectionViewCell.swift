//
//  StartCollectionViewCell.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/04.
//

import UIKit

class StartCollectionViewCell: UICollectionViewCell, BaseCellProtocol {
    
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
        nameStackView.designTamagotchiNameBorderLine()
        typeLabel.designTamagotchiName()
        baseLabel.designTamagotchiName()
        baseLabel.text = "다마고치"
        thumbImageView.contentMode = .scaleAspectFit
    }
    
    func configureCell(row: Tamagotchi) {
        baseLabel.isHidden = row.name == TamagotchiName.ready ? true : false
        typeLabel.text = row.name.rawValue
        thumbImageView.image = row.type == .ready ? UIImage(named: "noImage") : UIImage(named: row.defaultImgName)
    }
}
