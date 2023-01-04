//
//  TargetValueView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 11.11.2022.
//

import UIKit

final class TargetValueView: MMBaseContainerView {
    private var labelTarget: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.Colors.titleGray
        label.font = R.Fonts.helveticaRegular(with: 40)
        return label
    }()
    
   func configure(with target: Double) {
           let value = String(format: "%.02f", target)
           labelTarget.text = "\(value) ₽"
    }
}

extension TargetValueView {
    override func setupViews() {
        super.setupViews()
        setupView(labelTarget)
    }
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            labelTarget.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            labelTarget.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            labelTarget.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelTarget.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
    }
}
