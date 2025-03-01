//
//  AppRouter.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 23/02/2025.
//

import UIKit

class AppRouter {
    static func setRootViewController(_ viewController: UIViewController) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
