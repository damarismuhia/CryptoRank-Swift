//
//  OnboardingCollectionViewCell.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 23/02/2025.
//

import UIKit

class OnboardingCollectionViewCell:UICollectionViewCell{
    
    private var lbTitle: UILabel = {
        return UILabel(text: .localizable(.onboardingWelcome),
                       font: .sourceSanMedium(),
                       alignment: .center)
    }()
        
    private var lbDesc: UILabel = {
        return UILabel(text: .localizable(.onboardingWelcome),
                       font: .sourceSanRegular(14),
                   alignment: .center)
    }()
        
    private var logoImg: UIImageView = {
        let img = UIImageView(uiImage: nil)
        return img
    }()
    
    
    private let stackView: UIStackView = {
        let stackV = UIStackView(axio: .vertical, alignment: .center, spacing: 10)
        stackV.distribution = .fillProportionally
        return stackV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        contentView.addSubview(logoImg)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(lbTitle)
        stackView.addArrangedSubview(lbDesc)
            
        NSLayoutConstraint.activate([
            logoImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            logoImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logoImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: logoImg.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)

        ])
        
    }
    
    func configure(with model: OnboardingModel){
        logoImg.image = model.onboardingImage
        lbTitle.text = model.onboardingTitle
        lbDesc.text = model.onboardingDesc
    }

    
    
}
