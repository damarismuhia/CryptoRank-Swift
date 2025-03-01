//
//  NavTabBarController.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 23/02/2025.
//

import UIKit
class NavTabBarController: UITabBarController {
    let homeVC = HomeVC()
    let favoriteVc = FavoriteVC()
    let settingsVc = SettingsVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI(){
        view.backgroundColor = .background
        let homeNC = NavigationVC(rootViewController: homeVC)
        let favoriteNC = NavigationVC(rootViewController: favoriteVc)
        let settingsNC = NavigationVC(rootViewController: settingsVc)
        self.viewControllers = [homeNC, favoriteNC, settingsNC]
        
        self.tabBar.layer.masksToBounds = false
        self.tabBar.tintColor = .primaryApp
        self.tabBar.isTranslucent = false
        
        homeVC.tabBarItem = UITabBarItem(title: .localizable(.home), image: .systemImage("house"), tag: 0)
        favoriteVc.tabBarItem = UITabBarItem(title: .localizable(.favorite), image: .systemImage("heart.fill"), tag: 1)
        settingsVc.tabBarItem = UITabBarItem(title: .localizable(.settings), image: .systemImage("gear"), tag: 2)
        self.tabBar.layer.shadowColor = UIColor.darkGray.cgColor

    }
    
}

