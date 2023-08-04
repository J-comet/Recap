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
    @objc optional func configDelegate()
    func designVC()
    func configVC()
}
