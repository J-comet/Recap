//
//  Protocol+UIViewController.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/04.
//

import Foundation

@objc
protocol BaseViewControllerProtocol {
    @objc optional func configNavigationBar()
    func designVC()
    func configVC()
}
