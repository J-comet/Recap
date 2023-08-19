//
//  TutorialVC.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/07.
//

import UIKit

class TutorialVC: UIViewController, BaseViewControllerProtocol {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var pagerControl: UIPageControl!
    
    let tutorialInfo = TutorialInfo()
    
    var currentPage = 0 {
        didSet {
            pagerControl.currentPage = currentPage
            if currentPage  == tutorialInfo.list.count - 1 {
                startLabel.text = "시 작"
                startLabel.backgroundColor = .green
            } else {
                startLabel.text = "다 음"
                startLabel.backgroundColor = .blue
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        designVC()
        
//        collectionView.canCancelContentTouches = true
    }
    
    @IBAction func startLabelClicked(_ sender: UITapGestureRecognizer) {
        
        if pagerControl.currentPage == tutorialInfo.list.count - 1 {
            NotificationManager.shared.authorization {
                // 최초 앱 실행후 다마고치 선택안하고 앱 종료한 유저
                NotificationManager.shared.pushScheduledByHour(
                    title: "다마고치",
                    body: "귀여운 다마고치가 당신을 기다리고 있어요",
                    hour: NotificationManager.hour.mainSchedule.rawValue,
                    identifier: NotificationManager.identifier.schedule.rawValue
                )
            } endHandler: {
                DispatchQueue.main.async {
                    print("시작하기")
                    UserDefaults.isLaunched = false
                    let sb = UIStoryboard(name: StoryBoardId.Main.rawValue, bundle: nil)
                    guard let vc = sb.instantiateViewController(withIdentifier: SelectTamagotchiVC.identifier) as? SelectTamagotchiVC else {
                        return
                    }
                    
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    nav.modalTransitionStyle = .flipHorizontal
                    self.present(nav, animated: true)
                }
            }

        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func designVC() {
        setCollectionViewLayout()
        
        startLabel.text = "다 음"
        
        startLabel.layer.cornerRadius = 20
        startLabel.clipsToBounds = true
        startLabel.textAlignment = .center
        startLabel.backgroundColor = .blue
        startLabel.textColor = .white
        startLabel.font = .boldSystemFont(ofSize: 17)
        
        pagerControl.numberOfPages = tutorialInfo.list.count
        pagerControl.currentPage = 0
        pagerControl.pageIndicatorTintColor = .systemGray4
        pagerControl.currentPageIndicatorTintColor = .black
    }
    
    func configVC() {
        startLabel.isUserInteractionEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: TutorialCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TutorialCollectionViewCell.identifier)
    }
    
    private func setCollectionViewLayout() {
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
        
        // default false
        // 디바이스 가로 기준으로만 페이징 됨 따라서 아이템 너비가 고정일 때는 원하는 동작 X
        collectionView.isPagingEnabled = true
    }
}

extension TutorialVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tutorialInfo.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCollectionViewCell.identifier, for: indexPath) as? TutorialCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(row: tutorialInfo.list[indexPath.item])
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("begin")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("endding")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("endding Decel")
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        print("Scroll")
//        let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
//        let yPoint = scrollView.frame.height / 2
//        let center = CGPoint(x: xPoint, y: yPoint)
//        if let ip = collectionView.indexPathForItem(at: center) {
//            self.pagerControl.currentPage = ip.row
//
//            if pagerControl.currentPage  == tutorialInfo.list.count - 1 {
//                startLabel.text = "시 작"
//                startLabel.backgroundColor = .green
//            } else {
//                startLabel.text = "다 음"
//                startLabel.backgroundColor = .blue
//            }
//        }
//    }
    
}
