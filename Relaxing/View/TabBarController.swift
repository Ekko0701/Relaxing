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
        mainVC.tabBarItem.image = UIImage(named: "homeIcon")
        let MixVC = MixViewController()
        MixVC.tabBarItem.image = UIImage(named: "libraryIcon")
        viewControllers = [
            generateNavController(viewController: MainViewController(), title: "Home", image: UIImage(named: "homeIcon")),
            generateNavController(viewController: MixViewController(), title: "My Mix", image: UIImage(named: "libraryIcon")),
            generateNavController(viewController: SettingViewController(), title: "Setting", image: UIImage(named: "gearIcon"))
        ]
        
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundColor = UIColor(red: 0.09, green: 0.11, blue: 0.19, alpha: 1.00).withAlphaComponent(0.98)
    
        self.tabBar.unselectedItemTintColor = UIColor(red: 0.40, green: 0.54, blue: 0.51, alpha: 1.00)
        self.tabBar.tintColor = UIColor(red: 0.90, green: 0.87, blue: 0.77, alpha: 1.00)
        
        tabBar.layer.cornerRadius = tabBar.frame.height * 0.41
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    /**
     ViewController를 NavigationController로 반환하는 메소드
     */
    private func generateNavController(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        // Set TabBar Item
        viewController.tabBarItem.image = image
        
        // Set Navigation
        viewController.navigationItem.title = title.localized()
        let navController = UINavigationController(rootViewController: viewController)
        navController.isNavigationBarHidden = true

        return navController
    }
}
