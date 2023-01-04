//
//  TargetViewController.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 05.11.2022.
//

import UIKit

protocol TransferringValueViaTheCreateAGoalController {
    func additingTarget(with value: Double)
}

class TargetViewController: MMBaseController, TransferringValueViaTheCreateAGoalController {
    
    private var target = TargetModel.targetValue
    private var arrayTagInc = CoreDataService.shared.arrayTagInc
    private var arrayTagExp = CoreDataService.shared.arrayTagExp
    
    
    private let pathToTheGoal = PathToTheGoalView(with: R.Strings.Target.pathToTheGoal,
                                                  font: 23,
                                                  position: .center)
    private let targetValue = TargetValueView(with: R.Strings.Target.target,
                                              font: 23)
    private let collectedMoney = CollectedMoneyView(with: R.Strings.Target.collectedMoney,
                                                    font: 23)
    private let leftToRaiseMoney = LeftToRaiseMoneyView(with: R.Strings.Target.leftToRaiseMoney,
                                                        font: 23,
                                                        position: .right)
    private let buttonAddTarget = ButtonAddTargetView()
    private let transition = PanelTransitionController()
    private let createAGoalController = CreateAGoalController()
    
    
    @objc private func buttonAddTargetTapped() {
        if target != 0 {
            TargetModel.removeTargetValue()
            target = TargetModel.targetValue
            updateViews()
        } else {
            createAGoalController.transitioningDelegate = transition
            createAGoalController.modalPresentationStyle = .custom
            present(createAGoalController, animated: true)
        }
    }
    
    private func getingIncome(with array: [Tag]) -> Double {
        var value = 0.0
        for item in array {
            guard let tagValue = item.relationshipWithAuxiliaryEntitie?.tagValue else { return 0.0 }
            value += tagValue
        }
        return value
    }
    
    private func getingExpenditure(with array: [Tag]) -> Double {
        var value = 0.0
        for item in array {
            guard let tagValue = item.relationshipWithAuxiliaryEntitie?.tagValue else { return 0.0 }
            value += tagValue
        }
        return value
    }
    
    private func updateViews() {
        let income = getingIncome(with: arrayTagInc)
        let expenditure = getingExpenditure(with: arrayTagExp)
        let target = target ?? 0
        
        var moneyNow: Double {
            if target != 0 {
                return income - expenditure
            } else {
                return 0
            }
        }
        
        var raise: Double {
            if target != 0 {
                return target - moneyNow
            } else {
                return 0
            }
        }
        
        var isTarget: Bool {
            if target == 0 {
                return false
            } else {
                return true
            }
        }
        
        pathToTheGoal.configure(with: moneyNow,
                                raise: raise,
                                target: target)
        collectedMoney.configure(with: moneyNow)
        targetValue.configure(with: target)
        leftToRaiseMoney.configure(with: raise)
        buttonAddTarget.configure(with: isTarget,
                                  thereIsAPurposeTitle: R.Strings.Target.thereIsAPurposeTitle,
                                  thereIsNoPurposeTitle: R.Strings.Target.thereIsNoPurposeTitle)
        
        buttonAddTarget.buttonAddTarget.addTarget(self,
                                                  action: #selector(buttonAddTargetTapped),
                                                  for: .touchUpInside)
        
        if raise <= 0, target != 0 {
            let alert = UIAlertController(title: "Поздравляем🥳",
                                          message: "Вы достигли цели !!!",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Я молодец 😎",
                                       style: .cancel)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            return
        }
    }
    
    func additingTarget(with value: Double) {
        TargetModel.targetValue = value
        target = TargetModel.targetValue
        updateViews()
    }
}

extension TargetViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    override  func setupViews() {
        super.setupViews()
        
        view.setupView(pathToTheGoal)
        view.setupView(targetValue)
        view.setupView(collectedMoney)
        view.setupView(leftToRaiseMoney)
        view.setupView(buttonAddTarget)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            pathToTheGoal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            pathToTheGoal.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            pathToTheGoal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            targetValue.topAnchor.constraint(equalTo: pathToTheGoal.bottomAnchor, constant: 15),
            targetValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            targetValue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            collectedMoney.topAnchor.constraint(equalTo: targetValue.bottomAnchor, constant: 15),
            collectedMoney.trailingAnchor.constraint(equalTo:  view.centerXAnchor, constant: -15),
            collectedMoney.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            leftToRaiseMoney.topAnchor.constraint(equalTo: targetValue.bottomAnchor, constant: 15),
            leftToRaiseMoney.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            leftToRaiseMoney.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 15),
            
            buttonAddTarget.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            buttonAddTarget.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -150),
            buttonAddTarget.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 150)
            
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        title = R.Strings.Target.target
        navigationController?.tabBarItem.title = R.Strings.TabBar.title(for: .target)
        CreateAGoalController.delegate = self
    }
}

