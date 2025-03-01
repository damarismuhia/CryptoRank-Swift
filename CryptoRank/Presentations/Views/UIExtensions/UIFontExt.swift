//
//  UIFontExt.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 22/02/2025.
//
import UIKit
import SwiftUICore

extension UIFont {
    static func sourceSanLight(_ size: CGFloat = 17.0) -> UIFont  { return UIFont(name: "SourceSans3-Light", size: size)!}
    static func sourceSanRegular(_ size: CGFloat = 17.0) -> UIFont  { return UIFont(name: "SourceSans3-Regular", size: size)! }
    static func sourceSanMedium(_ size: CGFloat = 17.0) -> UIFont  { return UIFont(name: "SourceSans3-Medium", size: size)! }
    static func sourceSanBold(_ size: CGFloat = 17.0) -> UIFont  { return UIFont(name: "SourceSans3-Bold", size: size)! }
}


extension Font {
    static func sourceSanLight(_ size: CGFloat = 17.0) -> Font {
        return .custom("SourceSans3-Light", size: size)
    }
    
    static func sourceSanRegular(_ size: CGFloat = 17.0) -> Font {
        return .custom("SourceSans3-Regular", size: size)
    }
    
    static func sourceSanMedium(_ size: CGFloat = 17.0) -> Font {
        return .custom("SourceSans3-Medium", size: size)
    }
    
    static func sourceSanBold(_ size: CGFloat = 17.0) -> Font {
        return .custom("SourceSans3-Bold", size: size)
    }
}
