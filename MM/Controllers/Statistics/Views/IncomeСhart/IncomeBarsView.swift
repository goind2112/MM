//
//  IncomeBarsView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 17.11.2022.
//

import UIKit

final class IncomeBarsView: MMBaseView {
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        return view
    }()
    
    func configure(with data: [TagModelStatistics.TagStatistics]) {
        data.forEach {
            let incomeBarView = IncomeBarView(data: $0)
            stackView.addArrangedSubview(incomeBarView)
        }
    }
}


extension IncomeBarsView {
    override func setupViews() {
        super.setupViews()
        
        setupView(stackView)
    }
    override func constraintViews() {
        super.constraintViews()
    
        NSLayoutConstraint.activate([
                
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = .clear
    }
}

