//
//  ExpenditureView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 13.11.2022.
//

import UIKit

final class ExpenditureView: MMBaseContainerView {
    private let rightExpenditureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.Colors.titleRed
        label.font = R.Fonts.helveticaRegular(with: 17)
        return label
    }()
    func configure(with rightExpenditureValue: Double) {
        let value = String(format: "%.02f", rightExpenditureValue)
        rightExpenditureLabel.text = "\(rightExpenditureValue == 0.0 ? "" : "-")\(value) ₽"
    }
}

extension ExpenditureView {
    override func setupViews() {
        super.setupViews()
        setupView(rightExpenditureLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            rightExpenditureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            rightExpenditureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            rightExpenditureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            rightExpenditureLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
    }
}

