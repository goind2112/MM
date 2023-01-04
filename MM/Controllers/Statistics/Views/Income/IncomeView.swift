//
//  IncomeView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 13.11.2022.
//

import UIKit

final class IncomeView: MMBaseContainerView {
    private let leftIncomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.Colors.titleGreen
        label.font = R.Fonts.helveticaRegular(with: 17)
        return label
    }()
    func configure(with leftIncomeValue: Double) {
        let value = String(format: "%.02f", leftIncomeValue)
        leftIncomeLabel.text = "\(value) ₽"
    }
}

extension IncomeView {
    override func setupViews() {
        super.setupViews()
        setupView(leftIncomeLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            leftIncomeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            leftIncomeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            leftIncomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftIncomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
    }
}
