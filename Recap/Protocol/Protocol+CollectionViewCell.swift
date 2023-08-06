//
//  Protocol+CollectionViewCell.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/04.
//

import Foundation

protocol BaseCellProtocol {
    associatedtype T
    static var identifier: String { get }
    func designCell()
    func configureCell(row: T)
}
