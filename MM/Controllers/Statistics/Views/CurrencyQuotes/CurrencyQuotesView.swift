//
//  CurrencyQuotes.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 17.11.2022.
//

import UIKit

final class CurrencyQuotesView: MMBaseContainerView {
   
    private let dollarLabel: UILabel = {
        let lable = UILabel()
        lable.font = R.Fonts.helveticaRegular(with: 20)
        lable.textAlignment = .center
        lable.text = "Загрузка"
        lable.textColor = R.Colors.titleRed
        return lable
    }()
    
    private let euroLabel: UILabel = {
        let lable = UILabel()
        lable.font = R.Fonts.helveticaRegular(with: 20)
        lable.textAlignment = .center
        lable.text = "Загрузка"
        lable.textColor = R.Colors.titleGreen
        return lable
    }()
    
    func loanding() {
        euroLabel.text = "Загрузка"
        dollarLabel.text = "Загрузка"
    }
    
    func configure(with item: CurrencyQuotesDate) {
        
        let dollarArrow = item.dollarValueGrowing ? "↑" : "↓"
        let euroArrow = item.euroValueGrowing ? "↑" : "↓"
        
        dollarLabel.text = "USD: \(String(format: "%.02f", item.dollarValue))" + dollarArrow
        euroLabel.text = "EUR: \(String(format: "%.02f", item.euroValue))" + euroArrow
        
        dollarLabel.textColor = item.dollarValueGrowing ? R.Colors.titleGreen : R.Colors.titleRed
        euroLabel.textColor = item.euroValueGrowing ? R.Colors.titleGreen : R.Colors.titleRed
    }
}

extension CurrencyQuotesView {
    override func setupViews() {
        super.setupViews()
       setupView(dollarLabel)
       setupView(euroLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            dollarLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            dollarLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dollarLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -10),
            dollarLabel.topAnchor.constraint(equalTo: topAnchor),
            
            euroLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            euroLabel.leadingAnchor.constraint(equalTo: centerXAnchor,constant: 10),
            euroLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            euroLabel.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
    }
}
