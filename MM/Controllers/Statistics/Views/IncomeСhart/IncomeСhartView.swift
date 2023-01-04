//
//  IncomeСhartView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 17.11.2022.
//

import UIKit

final class IncomeСhartView: MMBaseContainerView {
    
    let incomeBarsView = IncomeBarsView()
    
    func configure(with array: [TagModelStatistics.TagStatistics]) {
        incomeBarsView.configure(with: array)
    }
}

extension IncomeСhartView {
    override func setupViews() {
        super.setupViews()
        setupView(incomeBarsView)
    }
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            
            incomeBarsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            incomeBarsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            incomeBarsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            incomeBarsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            ])
    }
    override func configureAppearance() {
        super.configureAppearance()
    }
}
