//
//  ButtonAddTargetView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 11.11.2022.
//

import UIKit

final class ButtonAddTargetView: MMBaseView {
    
    var buttonAddTarget = UIButton(type: .system)
    
    
    func configure(with value: Bool, thereIsAPurposeTitle: String, thereIsNoPurposeTitle: String) {
        if value {
            buttonAddTarget.setTitle(thereIsAPurposeTitle, for: .normal)
        } else {
            buttonAddTarget.setTitle(thereIsNoPurposeTitle, for: .normal)
        }
    }
}

extension ButtonAddTargetView {
    override func setupViews() {
        super.setupViews()
        setupView(buttonAddTarget)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            buttonAddTarget.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonAddTarget.bottomAnchor.constraint(equalTo: bottomAnchor),
            buttonAddTarget.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonAddTarget.topAnchor.constraint(equalTo: topAnchor),
            buttonAddTarget.widthAnchor.constraint(equalToConstant: 100)
        
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
        
        buttonAddTarget.titleLabel?.font = R.Fonts.helveticaRegular(with: 23)
        buttonAddTarget.setTitleColor(.white, for: .normal)
        buttonAddTarget.setTitleColor(R.Colors.inactive, for: .disabled)
        buttonAddTarget.backgroundColor = R.Colors.active
        buttonAddTarget.layer.cornerRadius = 17
    }
}
