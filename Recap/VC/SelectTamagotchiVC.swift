//
//  ViewController.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/04.
//

import UIKit

class SelectTamagotchiVC: UIViewController, BaseViewControllerProtocol {
    
    static var identifier = "SelectTamagotchiVC"
    
    @IBOutlet var collectionView: UICollectionView!
    
    let tamagochiInfo = TamagotchiInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designVC()
        configVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    func configNavigationBar() {
        title = UserDefaults.userInfo.tamagotchi == nil ? "다마고치 선택하기" : "다마고치 변경하기"
    }

    func designVC() {
        setBackgroundColor()
        setCollectionViewLayout()
    }
    
    func configVC() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: StartCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: StartCollectionViewCell.identifier)
    }

    private func setCollectionViewLayout() {
        collectionView.showsVerticalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let count: CGFloat = 3
        let width: CGFloat = UIScreen.main.bounds.width - (spacing * (count + 1)) // 디바이스 너비 계산
        
        layout.itemSize = CGSize(width: width / count, height: (width / count) * 1.2)
        layout.sectionInset = UIEdgeInsets(top: 20, left: spacing, bottom: 20, right: spacing)  // 컨텐츠가 잘리지 않고 자연스럽게 표시되도록 여백설정
        layout.minimumLineSpacing = 20         // 셀과셀 위 아래 최소 간격
        layout.minimumInteritemSpacing = 0    // 셀과셀 좌 우 최소 간격
        collectionView.collectionViewLayout = layout  // layout 교체
    }
}

extension SelectTamagotchiVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tamagochiInfo.getList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StartCollectionViewCell.identifier, for: indexPath) as? StartCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(row: tamagochiInfo.getList()[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let row = tamagochiInfo.getList()[indexPath.row]
    
        if row.type == .ready {
            showAlert(title: row.type.name, msg: "", ok: "확인")
        } else {
            let sb = UIStoryboard(name: StoryBoardId.Main.rawValue, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: PopupSelectTamagotchiVC.identifier) as! PopupSelectTamagotchiVC
            
            vc.selectedTamagotchi = row
            
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .overFullScreen
            present(nav, animated: true)
        }
    }
    
}

