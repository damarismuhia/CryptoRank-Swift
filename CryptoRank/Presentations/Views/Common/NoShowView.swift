//
//  NoShowView.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 01/03/2025.
//

import UIKit

class NoShowView:UIView{
    private lazy var logo:UIImageView = {
        return UIImageView(uiImage: .noSearch)
    }()
    private lazy var lbNarration: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()
    private lazy var emptyView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .clear
        return vw
    }()
    let btnRefresh: UIButton = {
        let btn =  UIButton(btnTit: .localizable(.refresh),
                            titleColor: .white)
        btn.layer.cornerRadius = 8
        return btn
    }()
    lazy var mainStack: UIStackView = {
        let sv = UIStackView(axio: .vertical, alignment: .center, spacing: 5)
        sv.distribution = .fill
        return sv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpUI(){
        backgroundColor = .background
        addSubview(mainStack)
        mainStack.addArrangedSubview(logo)
        mainStack.addArrangedSubview(lbNarration)
        mainStack.addArrangedSubview(emptyView)
        mainStack.addArrangedSubview(btnRefresh)
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5),
            mainStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            btnRefresh.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            btnRefresh.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            emptyView.heightAnchor.constraint(equalToConstant: 20),
            btnRefresh.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    func noShowErrorConfig(erorMsg: String,btnTit: String = .localizable(.refresh) ,_ isBtnHidden: Bool = true){
        lbNarration.text = erorMsg
        btnRefresh.isHidden = isBtnHidden
        btnRefresh.setTitle(btnTit, for: .normal)
        if(isBtnHidden == true){
            lbNarration.textColor = .label
            logo.image = .noSearch
            logInfo("GOT HERE AHHA \(erorMsg)")
        }else{
            logo.image = .errorIcon
            lbNarration.textColor = .red
        }
    }
}
