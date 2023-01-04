//
//  СostToIncomeRatioView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 13.11.2022.
//

import UIKit

final class СostToIncomeRatioView: MMBaseContainerView {
    
    private let costToIncomeRatioBarView = СostToIncomeRatioBarView()
    
    private let incomePercent: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = R.Fonts.helveticaRegular(with: 20)
        label.numberOfLines = 0
        return label
    }()
    
    func configure(with income: Double, expenditure: Double) {
        var percent: Double
        var incomePercent = 0.0
        
        let incomAndExpenditure = income + expenditure
        
        if income == 0.0 && expenditure == 0.0 {
            percent = 0.5
            incomePercent = 0.0
            let incomeLFormated = String(format: "%.02f", incomePercent)
            self.incomePercent.text = "\(incomeLFormated) %"
        } else {
            percent = income / incomAndExpenditure
            if percent != 0, percent < 0.01 {
                percent = 0.01
            }
            if percent != 1, percent > 0.99 {
                percent = 0.99
            }
            
            incomePercent = income * 100 / incomAndExpenditure
            if incomePercent != 0, incomePercent < 0.01 {
                incomePercent = 0.01
            }
            if incomePercent != 100, incomePercent > 99.99 {
                incomePercent = 99.99
            }
            
            let incomeLFormated = String(format: "%.02f", incomePercent)
            self.incomePercent.text = "Из общего числа трат и доходов \(incomeLFormated) % составляют доходы"
        }
        
        if percent > 0.5 {
            self.incomePercent.textColor = R.Colors.titleGreen
        } else {
            self.incomePercent.textColor = R.Colors.titleRed
        } 
        
        costToIncomeRatioBarView.drawRatio(with: percent)
    }
}

extension СostToIncomeRatioView {
    override func setupViews() {
        super.setupViews()
        
        setupView(costToIncomeRatioBarView)
        setupView(incomePercent)
        
    }
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            
            costToIncomeRatioBarView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            costToIncomeRatioBarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            costToIncomeRatioBarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            costToIncomeRatioBarView.heightAnchor.constraint(equalTo: costToIncomeRatioBarView.widthAnchor, constant: -190),
            costToIncomeRatioBarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            incomePercent.topAnchor.constraint(equalTo: costToIncomeRatioBarView.bottomAnchor, constant: -50),
            incomePercent.centerXAnchor.constraint(equalTo: centerXAnchor),
            incomePercent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            incomePercent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),

        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
    }
}
