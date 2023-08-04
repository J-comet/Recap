//
//  ViewController.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/04.
//

import UIKit

class StartVC: UIViewController, BaseViewControllerProtocol {
    
    static var identifier = "StartVC"
    
    @IBOutlet var collectionView: UICollectionView!
    
    var list: [Tamagotchi] = [Tamagotchi(idx: 0),Tamagotchi(idx: 1),Tamagotchi(idx: 2),Tamagotchi(idx: 3),Tamagotchi(idx: 4),Tamagotchi(idx: 5),Tamagotchi(idx:6)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        designVC()
        configVC()
    }
    
    func configNavigationBar() {
        title = "다마고치 선택하기"
    }

    func designVC() {
        setCollectionViewLayout()
    }
    
    func configVC() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: StartCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: StartCollectionViewCell.identifier)
    }

    private func setCollectionViewLayout() {
        // 비율 계산해서 디바이스 별로 UI 설정
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let count: CGFloat = 3
        let width: CGFloat = UIScreen.main.bounds.width - (spacing * (count + 1)) // 디바이스 너비 계산
        
        layout.itemSize = CGSize(width: width / count, height: width / count)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)  // 컨텐츠가 잘리지 않고 자연스럽게 표시되도록 여백설정
        layout.minimumLineSpacing = spacing         // 셀과셀 위 아래 최소 간격
        layout.minimumInteritemSpacing = spacing    // 셀과셀 좌 우 최소 간격
        collectionView.collectionViewLayout = layout  // layout 교체
    }
}

extension StartVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartCollectionViewCell.identifier, for: indexPath) as? StartCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(row: list[indexPath.row])
        return cell
    }
    
}

