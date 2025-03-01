//
//  OnboardDataServiceProtocol.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 01/03/2025.
//


protocol OnboardingServiceProtocol: AnyObject {
    func fetchOnboardingItems() -> [OnboardingModel]
}
