//
//  OnboardDataService.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 23/02/2025.
//


class OnboardDataService : OnboardingServiceProtocol{
    func fetchOnboardingItems() -> [OnboardingModel] {
        let onboardingItems = [
            OnboardingModel(
                onboardingImage: .sliderOneLogo,
                onboardingTitle: .localizable(.sliderTitleOne),
                onboardingDesc: .localizable(.sliderDescOne)
            ),
            OnboardingModel(
                onboardingImage: .sliderTwoLogo,
                onboardingTitle: .localizable(.sliderTitleTwo),
                onboardingDesc: .localizable(.sliderDescTwo)
            ),
            OnboardingModel(
                onboardingImage: .sliderThreeLogo,
                onboardingTitle: .localizable(.sliderTitThree),
                onboardingDesc: .localizable(.sliderDescThree)
            ),
        ]
        return onboardingItems
    }
    
          
}
