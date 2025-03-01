//
//  UserDefaultConfig.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 23/02/2025.
//

import Foundation

class UserDefaultConfig {
    static func getValue<T>(defaultValue: T, forKey key: String) -> T{
        let defaults = UserDefaults.standard
        return defaults.object(forKey: key) as? T ?? defaultValue
    }

    static func saveValue(value: Any, forKey key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
}

