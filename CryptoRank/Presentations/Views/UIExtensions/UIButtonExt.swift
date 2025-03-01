//
//  UIButtonExt.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 22/02/2025.
//

import Foundation
import UIKit
extension UIButton {
    convenience init(btnTit: String,
                     backgroundolor: UIColor = .primaryApp,
                     titleColor: UIColor = .label,
                     font: UIFont = .sourceSanMedium()) {
        self.init(frame: .zero)
        self.setTitle(btnTit, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundolor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

