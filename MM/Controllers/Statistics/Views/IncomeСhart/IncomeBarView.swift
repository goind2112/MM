//
//  IncomeChartView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 17.11.2022.
//

import UIKit

final class IncomeBarView: MMBaseView { 
    
    private let heightMultiplier: Double
    private let conditionValue: TypeOfOperation
    
    private let incomeLabel: UILabel = {
        let ladel = UILabel()
        ladel.textColor = R.Colors.titleGray
        ladel.font = R.Fonts.helveticaRegular(with: 10)
        ladel.textAlignment = .center
        return ladel
    }()
    
    private let incomeLine: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    init(data: TagModelStatistics.TagStatistics) {
        self.heightMultiplier = data.value
        self.conditionValue = data.condition
        super.init(frame: .zero)
        
        incomeLabel.text = data.tagName
    }
    
    required init?(coder: NSCoder) {
        self.heightMultiplier = 0
        self.conditionValue = .income
        super.init(coder: coder)
    }
}
    
    
extension IncomeBarView {
    
    override func setupViews() {
        super.setupViews()
        setupView(incomeLabel)
        setupView(incomeLine)
    }
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            incomeLine.bottomAnchor.constraint(equalTo: incomeLabel.topAnchor, constant: -5),
            incomeLine.centerXAnchor.constraint(equalTo: centerXAnchor),
            incomeLine.widthAnchor.constraint(equalToConstant: 17),
            incomeLine.heightAnchor.constraint(equalTo: heightAnchor, multiplier: heightMultiplier),
            
            incomeLabel.topAnchor.constraint(equalTo: incomeLine.bottomAnchor),
            incomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            incomeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
        incomeLine.backgroundColor = conditionValue == .income ? R.Colors.titleGreen : R.Colors.titleRed
    }
}
