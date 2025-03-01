//
//  SettingsVC.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 25/02/2025.
//
/**
 * theme  toggle,
 * App details, version
 *
 */
import UIKit
class SettingsVC: DefaultVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: .localizable(.settings), style: .plain, target: nil, action: nil)
    }
            
}
