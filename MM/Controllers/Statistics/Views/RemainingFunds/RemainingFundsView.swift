//
//  RemainingFundsView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 13.11.2022.
//

import UIKit

final class RemainingFundsView: MMBaseContainerView {
    private var labelRemaining: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = R.Fonts.helveticaRegular(with: 40)
        return label
    }()
    
   func configure(with remaining: Double) {
       if remaining < 0.0 {
           labelRemaining.textColor = R.Colors.titleRed
       } else {
           labelRemaining.textColor = R.Colors.titleGreen
       }
        let value = String(format: "%.02f", remaining)
        labelRemaining.text = "\(value) ₽"
    }
}

extension RemainingFundsView {
    override func setupViews() {
        super.setupViews()
        setupView(labelRemaining)
    }
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            labelRemaining.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            labelRemaining.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            labelRemaining.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelRemaining.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
    }
}
