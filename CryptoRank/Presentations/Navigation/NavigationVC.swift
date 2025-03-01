//
//  NavigationVC.swift
//  MSelenCustomerApp
//
//  Created by Damaris Muhia on 24/08/2023.
//

import Foundation
import UIKit
class NavigationVC: UINavigationController{
    let appearance = UINavigationBarAppearance()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        navigationBar.barTintColor = .primaryApp
        navigationBar.tintColor = .white
        self.view.backgroundColor = .background
        
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primaryApp
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Title color
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // Large title color
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
       
       
    
    
    
}
