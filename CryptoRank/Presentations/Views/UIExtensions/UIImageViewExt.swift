//
//  UIImageViewExt.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 23/02/2025.
//

import UIKit
import SDWebImageSVGCoder
extension UIImageView {
    
    convenience init(uiImage: UIImage?, contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.init(frame: .zero)
        self.image = uiImage
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = contentMode
    }
    
    func setupImageView(with urlString: String) {
        let svgCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(svgCoder)
        self.sd_setImage(with: URL(string: urlString),
                              placeholderImage: nil,
                              options: [.progressiveLoad, .retryFailed]) { image, error, cacheType, url in
            if let error = error {
                self.image = .logo //
                logInfo("Failed to load image: \(error)")
            }
        }
    }
}


