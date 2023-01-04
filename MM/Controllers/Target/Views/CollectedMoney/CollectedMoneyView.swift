//
//  ThereIsView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 11.11.2022.
//

import UIKit

final class CollectedMoneyView: MMBaseContainerView {
    private let collectedMoneyLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.Colors.titleGray
        label.font = R.Fonts.helveticaRegular(with: 17)
        return label
    }()
    func configure(with collectedValue: Double) {
        let value = String(format: "%.02f", collectedValue)
        collectedMoneyLable.text = "\(value) ₽"
    }
}

extension CollectedMoneyView {
    override func setupViews() {
        super.setupViews()
        setupView(collectedMoneyLable)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            collectedMoneyLable.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            collectedMoneyLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            collectedMoneyLable.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectedMoneyLable.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
    }
}
