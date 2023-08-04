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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
    }

    func designCell() {
        
    }
    
    func configureCell(row: Tamagotchi) {
        
    }
}
