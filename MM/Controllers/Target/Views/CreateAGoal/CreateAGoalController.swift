//
//  ChildViewController.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 03.12.2022.
//

import UIKit

final class CreateAGoalController: MMBaseController {
    
   static var delegate: TransferringValueViaTheCreateAGoalController?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.Colors.titleGray
        label.font = R.Fonts.helveticaRegular(with: 38)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = R.Colors.titleGray
        label.font = R.Fonts.helveticaRegular(with: 23)
        return label
    }()
    
    private let targetField: UITextField = {
        let textField = UITextField()
        textField.font = R.Fonts.helveticaRegular(with: 23)
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.textColor = R.Colors.titleGray
        textField.backgroundColor = R.Colors.background
        return textField
    }()
    
    private let targetButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = R.Fonts.helveticaRegular(with: 23)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(R.Colors.inactive, for: .disabled)
        button.layer.cornerRadius = 17
        button.backgroundColor = R.Colors.active
        button.setTitle(R.Strings.Target.sav, for: .normal)
        return button
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = R.Fonts.helveticaRegular(with: 23)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(R.Colors.inactive, for: .disabled)
        button.layer.cornerRadius = 17
        button.backgroundColor = R.Colors.titleGray
        button.setTitle(R.Strings.Target.close, for: .normal)
        return button
    }()
    
    private let borderLine: UIView = {
        let view = UIView()
        view.backgroundColor = R.Colors.inactive
        return view
    }()
    
    private let stackViewHor: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let stackViewVert: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fillProportionally
        return stack
    }()
    
    @objc private func addTargetButtonTap() {
        guard let target = targetField.text else { return }
        
        if targetField.text == "" {
            addingAlert(with: "Ошибка😡",
                        message: "Если не хотите заполнять просто нажмите \"Закрыть\"🤷🏻‍♂️")
            return
        }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        guard let value = formatter.number(from: target) else {
            addingAlert(with: "Ошибка😡",
                        message: "Формат не поддерживается введите число, например: 1000.00")
            return
        }
        
        let valueDouble = Double(truncating: value)
        CreateAGoalController.delegate?.additingTarget(with: valueDouble)
        targetField.text = ""
        dismiss(animated: true)
    }
    
    @objc private func dismissButtonTap() {
        dismiss(animated: true)
    }
}

extension CreateAGoalController {
    override func setupViews() {
        super.setupViews()

        stackViewHor.addArrangedSubview(targetButton)
        stackViewHor.addArrangedSubview(borderLine)
        stackViewHor.addArrangedSubview(dismissButton)
        
        stackViewVert.addArrangedSubview(titleLabel)
        stackViewVert.addArrangedSubview(descriptionLabel)
        stackViewVert.addArrangedSubview(targetField)
        stackViewVert.addArrangedSubview(stackViewHor)
        view.setupView(stackViewVert)
    }
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            
            borderLine.widthAnchor.constraint(equalToConstant: 1),
            targetButton.heightAnchor.constraint(equalToConstant: 50),
            dismissButton.heightAnchor.constraint(equalToConstant: 50),
            targetField.heightAnchor.constraint(equalToConstant: 40),
            
            stackViewVert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackViewVert.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackViewVert.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
        view.backgroundColor = .white
        view.layer.cornerRadius = 17
        
        titleLabel.text = R.Strings.Target.createAGoal
        descriptionLabel.text = R.Strings.Target.descriptionLabel
        
        targetButton.addTarget(self,
                               action: #selector(addTargetButtonTap),
                               for: .touchUpInside)
        dismissButton.addTarget(self,
                                action: #selector(dismissButtonTap),
                                for: .touchUpInside)
    }
}
