//
//  UIImageExt.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 01/03/2025.
//

import UIKit

extension UIImage {
    static func systemImage( _ imageRef: String) -> UIImage {
        return UIImage(systemName: imageRef) ?? UIImage()
    }
}
