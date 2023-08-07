//
//  TutorialCollectionViewCell.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/07.
//

import UIKit

class TutorialCollectionViewCell: UICollectionViewCell, BaseCellProtocol {
    
    static var identifier = "TutorialCollectionViewCell"
    typealias T = Tutorial

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
    }

    func designCell() {
        contentLabel.textColor = MainColor.fontOrStroke.value
        contentLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        contentLabel.textAlignment = .center
        mainImageView.contentMode = .center
        
    }
    
    func configureCell(row: Tutorial) {
        contentLabel.text = row.content
        mainImageView.image = UIImage(named: row.img)
        mainImageView.backgroundColor = row.bgColor
    }
}
