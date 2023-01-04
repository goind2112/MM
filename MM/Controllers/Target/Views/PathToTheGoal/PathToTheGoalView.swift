//
//  MyTargetView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 09.11.2022.
//

import UIKit

final class PathToTheGoalView: MMBaseContainerView {
   private let progressBarView = ProgressBarView()
    
    private let percentNow: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.Colors.titleGray
        label.font = R.Fonts.helveticaRegular(with: 23)
        return label
    }()
    
    private let percentRemaining: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.Colors.titleGray
        label.font = R.Fonts.helveticaRegular(with: 23)
        return label
    }()
    
    private let bottomSeparatorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = R.Colors.separator
        
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 30
        stack.distribution = .fillProportionally
       return stack
    }()
    
    func configure(with moneyNow: Double, raise: Double, target: Double) {
        var percent: Double
        var pNow: Double
        var pRemaining: Double
        
        if target != 0.0 {
            if raise <= 0.0 {
                percent = 1.0
                pNow = moneyNow * 100 / target
                pRemaining = raise * 100 / target
            } else {
                percent = moneyNow / target
                if percent != 0, percent > 0.99 {
                    percent = 0.99
                }
                pNow = moneyNow * 100 / target
                if pNow != 0, pNow > 99.99 {
                    pNow = 99.99
                }
                pRemaining = raise * 100 / target
                if pRemaining != 0, pRemaining < 0.01 {
                    pRemaining = 0.01
                }
            }
        } else {
            percent = 0.0
            pNow = 0.0
            pRemaining = 100.0
        }
        
        let pNowFormated = String(format: "%.02f", pNow)
        let pRemainingFormated = String(format: "%.02f", pRemaining)
        
        percentNow.text = "\(pNowFormated) %"
        percentRemaining.text = "\(pRemainingFormated) %"
        progressBarView.drawProgress(with: percent)
    }
}

extension PathToTheGoalView {
    override func setupViews() {
        super.setupViews()
        
        setupView(progressBarView)
        setupView(stackView)
        stackView.addArrangedSubview(percentNow)
        stackView.addArrangedSubview(bottomSeparatorView)
        stackView.addArrangedSubview(percentRemaining)
        
    }
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            percentNow.widthAnchor.constraint(equalToConstant: 100),
            percentRemaining.widthAnchor.constraint(equalToConstant: 100),
            
            progressBarView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            progressBarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            progressBarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            progressBarView.heightAnchor.constraint(equalTo: progressBarView.widthAnchor, constant: -190),
            progressBarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            stackView.topAnchor.constraint(equalTo: progressBarView.bottomAnchor, constant: -40),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            bottomSeparatorView.widthAnchor.constraint(equalToConstant: 1)
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
    }
}
