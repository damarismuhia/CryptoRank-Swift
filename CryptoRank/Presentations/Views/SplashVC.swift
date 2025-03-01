//
//  SplashVC.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 23/02/2025.
//

// to-do - security checks
import UIKit
class SplashVC: UIViewController {
    
    private let logoImg: UIImageView = {
        let img = UIImageView(uiImage: .logo)
        return img
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        setUpUI()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigateToNextScreen()
        }
    }
    
    private func setUpUI(){
        view.addSubview(logoImg)
        NSLayoutConstraint.activate([
            logoImg.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoImg.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    private func navigateToNextScreen(){
       
        if UserDefaultConfig.getValue(defaultValue: false, forKey: CacheKeys.KEY_WALKTHROUGH_DONE){
            let tabContoller = NavTabBarController()
            AppRouter.setRootViewController(tabContoller)
        }else {
            let vc = WalkThroughVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            AppRouter.setRootViewController(nav)
        }
        
    }
    
}
