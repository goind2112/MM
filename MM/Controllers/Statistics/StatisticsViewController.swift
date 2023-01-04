//
//  StatisticsViewController.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 05.11.2022.
//

import UIKit
import SwiftUI

class StatisticsViewController: MMBaseController {
    
    private var arrayTagInc = CoreDataService.shared.arrayTagInc
    private var arrayTagExp = CoreDataService.shared.arrayTagExp
    private var arrayTagStatistics = TagModelStatistics.shared.arrayTagStatistics
    private let tagModelStatistics = TagModelStatistics.shared
    
    private var income = 0.0
    private var expenditure = 0.0
    private var remaining: Double {
        return income - expenditure
    }
    
    private let costToIncomeRatioView = СostToIncomeRatioView(with: R.Strings.Statistics.earningsIndex,
                                                              font: 23,
                                                              position: .center)
    private let incomeView = IncomeView(with: R.Strings.Statistics.incomeView,
                                        font: 23)
    private let expenditureView = ExpenditureView(with: R.Strings.Statistics.expenditureView,
                                                  font: 23,
                                                  position: .right)
    private let remainingFundsView = RemainingFundsView(with: R.Strings.Statistics.remainingFundsView,
                                                        font: 23,
                                                        position: .center)
    private let incomeСhartView = IncomeСhartView(with: R.Strings.Statistics.incomeСhartView,
                                                  font: 23,
                                                  position: .center)
    private let currencyQuotesView = CurrencyQuotesView()
    
    private func getIncome(with array: [Tag]) {
        var value = 0.0
        for item in array {
            guard let tagValue = item.relationshipWithAuxiliaryEntitie?.tagValue else { return }
            value += tagValue
        }
        self.income = value
    }
    
    private func getExpenditure(with array: [Tag]) {
        var value = 0.0
        for item in array {
            guard let tagValue = item.relationshipWithAuxiliaryEntitie?.tagValue else { return }
            value += tagValue
        }
        self.expenditure = value
    }
    
    private func reloadCurrencyQuotes() {
        JSONParser().request { [weak self] valute, error in
            var dollarValueGrowing = true
            var euroValueGrowing = true
            
            self?.currencyQuotesView.loanding()
            
            guard let usd = valute?.Valute["USD"] else { return }
            guard let eur = valute?.Valute["EUR"] else { return }
            
            if UserDefaults.standard.double(forKey: "usd") <= usd.Value{
                dollarValueGrowing = true
            } else {
                dollarValueGrowing = false
            }
            
            if UserDefaults.standard.double(forKey: "eur") <= eur.Value{
                euroValueGrowing = true
            } else {
                euroValueGrowing = false
            }
            
            UserDefaults.standard.set(usd.Value, forKey: "usd")
            UserDefaults.standard.set(eur.Value, forKey: "eur")
            
            self?.currencyQuotesView.configure(with: CurrencyQuotesDate(dollarValueGrowing: dollarValueGrowing, euroValueGrowing: euroValueGrowing, dollarValue: usd.Value, euroValue: eur.Value))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 120, execute:{
                self?.reloadCurrencyQuotes()
                print("Currency quotes updated")
            })
        }
    }
    
}

extension StatisticsViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tagModelStatistics.arrayFilling()
        arrayTagStatistics = TagModelStatistics.shared.arrayTagStatistics
        incomeСhartView.configure(with: arrayTagStatistics)
        
        getIncome(with: arrayTagInc)
        getExpenditure(with: arrayTagExp)
        
        incomeView.configure(with: income)
        expenditureView.configure(with: expenditure)
        remainingFundsView.configure(with: remaining)
        costToIncomeRatioView.configure(with: income, expenditure: expenditure)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let subviews = incomeСhartView.incomeBarsView.stackView.arrangedSubviews
        for item in subviews {
            item.removeFromSuperview()
            
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.setupView(costToIncomeRatioView)
        view.setupView(incomeView)
        view.setupView(expenditureView)
        view.setupView(remainingFundsView)
        view.setupView(incomeСhartView)
        view.setupView(currencyQuotesView)
        
    }
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            costToIncomeRatioView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            costToIncomeRatioView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            costToIncomeRatioView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            incomeView.topAnchor.constraint(equalTo: costToIncomeRatioView.bottomAnchor, constant: 5),
            incomeView.trailingAnchor.constraint(equalTo:  view.centerXAnchor, constant: -15),
            incomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            expenditureView.topAnchor.constraint(equalTo: costToIncomeRatioView.bottomAnchor, constant: 5),
            expenditureView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            expenditureView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 15),
            
            remainingFundsView.topAnchor.constraint(equalTo: incomeView.bottomAnchor, constant: 5),
            remainingFundsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            remainingFundsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            incomeСhartView.topAnchor.constraint(equalTo: remainingFundsView.bottomAnchor, constant: 5),
            incomeСhartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            incomeСhartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            currencyQuotesView.topAnchor.constraint(equalTo:incomeСhartView.bottomAnchor, constant: 5),
            currencyQuotesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            currencyQuotesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            currencyQuotesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
        
        title = R.Strings.Statistics.statistics
        navigationController?.tabBarItem.title = R.Strings.TabBar.title(for: .statistics)
        
        reloadCurrencyQuotes()
        
    }
}
