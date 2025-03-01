//
//  CacheKeys.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 23/02/2025.
//

import Foundation
import UIKit


struct CacheKeys{
    static let KEY_WALKTHROUGH_DONE = "KEY_WALKTHROUGH_DONE"
    static let IMAGE_SIZE = UIScreen.main.traitCollection.userInterfaceIdiom == .phone ? 40.0 : 60.0
    static let MAX_COINS = 100
    
}

func logError(_ obj: Any?) {
    debugPrint("❌: \(String(describing: obj))")
}
func logInfo(_ obj: Any?) {
    debugPrint("✅: \(String(describing: obj))")
}
