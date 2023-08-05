//
//  SceneDelegate.swift
//  Recap
//
//  Created by 장혜성 on 2023/08/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // 윈도우를 코드로 다룰 수 있게 변환
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        // 1. 처음 앱 실행한 유저인지 확인
        // 2. 다마고치를 생성했는 유저인지 확인
        let isLaunched = UserDefaults.isLaunched
        print("첫실행 =",isLaunched)
        print("유저정보 =",UserDefaults.userInfo)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if isLaunched {
            UserDefaults.isLaunched = false
            guard let vc = sb.instantiateViewController(withIdentifier: SelectTamagotchiVC.identifier) as? SelectTamagotchiVC else {
                return
            }
            window?.rootViewController = UINavigationController(rootViewController: vc)
            window?.makeKeyAndVisible()
        } else {
            let vc = UserDefaults.userInfo.tamagotchi == nil ? sb.instantiateViewController(withIdentifier: SelectTamagotchiVC.identifier) as? SelectTamagotchiVC : sb.instantiateViewController(withIdentifier: MainVC.identifier) as? MainVC
            
            if let vc {
                window?.rootViewController = UINavigationController(rootViewController: vc)
                window?.makeKeyAndVisible()
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

