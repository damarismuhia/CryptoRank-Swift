//
//  DefaultVC.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 25/02/2025.
//

import UIKit
class DefaultVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String, message: String, buttonTitle: String = .localizable(.okay)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        present(alert, animated: true)
    }
    
    func getTimeGreetingVerb() -> String{
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
            case 0..<12 :
                return .localizable(.greetingsMorning)
            case 12..<16 :
                return .localizable(.greetingsAfternoon)
            case 16..<20 :
            return .localizable(.greetingsEvening)
            default:
            return .localizable(.greetingsGoodnight)
        }
    }
    
}
