//
//  TabBarController.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    /**
     탭바 설정 메소드
     */
    private func configureTabBar() {
        self.delegate = self
        self.selectedIndex = 0
        
        let mainVC = MainViewController()
        mainVC.tabBarItem.image = UIImage(systemName: "house")
        let MixVC = MixViewController()
        MixVC.tabBarItem.image = UIImage(systemName: "play.square.stack")
        viewControllers = [
            generateNavController(viewController: MainViewController(), title: "소리", image: UIImage(systemName: "house")),
            MixVC,
            generateNavController(viewController: SettingViewController(), title: "Setting", image: UIImage(systemName: "gearshape"))
        ]
        
        self.tabBar.backgroundColor = .white.withAlphaComponent(0.5)
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .systemBlue
    }
    
    /**
     ViewController를 NavigationController로 반환하는 메소드
     */
    private func generateNavController(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        // Set TabBar Item
        viewController.tabBarItem.image = image
        
        // Set Navigation
        viewController.navigationItem.title = title
        let navController = UINavigationController(rootViewController: viewController)
        navController.isNavigationBarHidden = true

        return navController
    }
}
