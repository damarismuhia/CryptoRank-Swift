//
//  OnboardViewModel.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 24/02/2025.
//

class OnboardViewModel : AnyObject {
    
    private let onboardService: OnboardingServiceProtocol
    private lazy var onboardingItems: [OnboardingModel] = []
    
    
    init(onboardService: OnboardingServiceProtocol = OnboardDataService()) {
        self.onboardService = onboardService
    }
    
    
    func fetchOnboardingItems(){
        onboardingItems = onboardService.fetchOnboardingItems()
    }
    
    var numberOfPages: Int {
        return onboardingItems.count
    }
    func getOnboardingModel(at index: Int) -> OnboardingModel{
        return onboardingItems[index]
    }
    
}




