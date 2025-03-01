//
//  UIStackViewExt.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 23/02/2025.
//

import UIKit

extension UIStackView {
    
    convenience init(axio: NSLayoutConstraint.Axis = .vertical,
                     alignment: UIStackView.Alignment,
                     spacing: CGFloat) {
        self.init(frame: .zero)
        self.axis = axio
        self.alignment = alignment
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
}

