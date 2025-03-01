//
//  UILabelExt.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 23/02/2025.
//

import Foundation
import UIKit
extension UILabel {
    convenience init(text: String = "",
                     font: UIFont = .sourceSanRegular(),
                     textColor: UIColor = .label,
                     alignment: NSTextAlignment = .left) {
            self.init(frame: .zero)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.text = text
            self.font = font
            self.textColor = textColor
            self.textAlignment = alignment
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping
        }
}
