//
//  LeftToRaiseMoneyView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 11.11.2022.
//

import UIKit

final class LeftToRaiseMoneyView: MMBaseContainerView {
    private let leftToRaiseMoneyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.Colors.titleGray
        label.font = R.Fonts.helveticaRegular(with: 17)
        return label
    }()
    func configure(with leftToRaiseValue: Double) {
        let value = String(format: "%.02f", leftToRaiseValue)
        leftToRaiseMoneyLabel.text = "\(value) ₽"
    }
}

extension LeftToRaiseMoneyView {
    override func setupViews() {
        super.setupViews()
        setupView(leftToRaiseMoneyLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            leftToRaiseMoneyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            leftToRaiseMoneyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            leftToRaiseMoneyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftToRaiseMoneyLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
    }
}
