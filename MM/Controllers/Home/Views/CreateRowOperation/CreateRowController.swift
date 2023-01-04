//
//  CreateRowIncOrExpController.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 06.12.2022.
//

import UIKit

protocol TagTransfer: AnyObject {
    func tagTransfer(with tag: Tag)
}

final class CreateRowController: MMBaseController, TagTransfer {
   
    weak var delegate: TransferringDataViaTheSavButton?
    private var tag: Tag?
    private let arrayTagInc = HomeViewController.arrayTagInc
    private let arrayTagExp = HomeViewController.arrayTagExp
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = R.Fonts.helveticaRegular(with: 23)
        label.textColor = R.Colors.titleGray
        label.text = R.Strings.Home.nameLabel
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = R.Fonts.helveticaRegular(with: 20)
        textField.borderStyle = .roundedRect
        textField.textColor = .lightGray
        textField.backgroundColor = .white
        textField.text = "Введите название операции..."
        return textField
    }()
    
    private let sumLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = R.Fonts.helveticaRegular(with: 23)
        label.textColor = R.Colors.titleGray
        label.text = R.Strings.Home.sumLabel
        return label
    }()
    
    private let sumTextField: UITextField = {
        let textField = UITextField()
        textField.font = R.Fonts.helveticaRegular(with: 20)
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.textColor = .lightGray
        textField.backgroundColor = .white
        textField.text = "Введите сумму операции..."
        return textField
    }()
    
    private let expLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = R.Fonts.helveticaRegular(with: 23)
        label.textColor = R.Colors.titleGray
        label.text = R.Strings.Home.expLabel
        return label
    }()
    
    private let switchExpOrinc: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = R.Colors.titleGreen
        mySwitch.backgroundColor = R.Colors.titleRed
        mySwitch.layer.cornerRadius = 15.9
        return mySwitch
    }()
    
    private let incLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = R.Fonts.helveticaRegular(with: 23)
        label.textColor = R.Colors.titleGray
        label.text = R.Strings.Home.incLabel
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        return stack
    }()
    
    private let pickerViewIncOrExp = PickerViewIncOrExp()
    
    private let savButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = R.Fonts.helveticaRegular(with: 23)
        button.layer.cornerRadius = 17
        button.backgroundColor = R.Colors.active
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(R.Colors.inactive, for: .disabled)
        button.setTitle(R.Strings.Home.sav, for: .normal)
        return button
    }()
    
    private let hideKeyboardButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = R.Fonts.helveticaRegular(with: 17)
        button.layer.cornerRadius = 15
        button.backgroundColor = R.Colors.active
        button.setTitleColor(.white, for: .normal)
        button.setTitle(R.Strings.Home.hideKeyboard, for: .normal)
        button.isHidden = true
        return button
    }()
    
    @objc private func savButtonTaped () {
        guard let name = nameTextField.text else { return }
        
        if name == "" || nameTextField.textColor == .lightGray {
            addingAlert(with: "Ошибка😡",
                        message: "Поле: \"Наименование\" обязательно для заполнения!!!")
            return
        }
        
        guard let value = sumTextField.text else { return }
        
        if sumTextField.text == "" || sumTextField.textColor == .lightGray {
            addingAlert(with: "Ошибка😡",
                        message: "Поле: \"Сумма\" обязательно для заполнения!!!")
            return
        }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        guard let value = formatter.number(from: value) else {
            addingAlert(with: "Ошибка😡",
                        message: "Формат не поддерживается введите число, например: 1000.00")
            return
        }
        
        let valueDouble = Double(truncating: value)
        
        guard let tag = self.tag else { return }
        
        delegate?.saveData(name, value: valueDouble, tag: tag)
        
        nameTextField.text = ""
        sumTextField.text = ""
        pickerViewIncOrExp.pickerView.selectRow(0, inComponent: 0, animated: false)
        switchExpOrinc.isOn = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc private func toggelIncOrExp(target: UISwitch) {
        if target.isOn {
            pickerViewIncOrExp.arratTag = arrayTagInc
            pickerViewIncOrExp.pickerView.reloadAllComponents()
            pickerViewIncOrExp.pickerView.selectRow(0, inComponent: 0, animated: true)
            view.endEditing(true)
            tag = pickerViewIncOrExp.arratTag[0]
            print("Sistem: \" condition pickerViewIncOrExp:\(pickerViewIncOrExp.condition)\"")
        } else {
            pickerViewIncOrExp.arratTag = arrayTagExp
            pickerViewIncOrExp.pickerView.reloadAllComponents()
            pickerViewIncOrExp.pickerView.selectRow(0, inComponent: 0, animated: true)
            tag = pickerViewIncOrExp.arratTag[0]
            print("Sistem: \" condition pickerViewIncOrExp:\(pickerViewIncOrExp.condition)\"")
            view.endEditing(true)
        }
    }
    @objc private func keyboardShow() {
        hideKeyboardButton.isHidden = false
    }
    
    @objc private func keyboardHide() {
        hideKeyboardButton.isHidden = true
    }
    
    //MARC: - delegat (TagTransfer)
    func tagTransfer(with tag: Tag) {
        self.tag = tag
    }
}


extension CreateRowController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.text = "Введите название операции..."
        nameTextField.textColor = .lightGray
        
        sumTextField.text = "Введите сумму операции..."
        sumTextField.textColor = .lightGray
        
        
        pickerViewIncOrExp.arratTag = arrayTagExp
        pickerViewIncOrExp.pickerView.reloadAllComponents()
    }
    override func setupViews() {
        super.setupViews()
        view.setupView(nameLabel)
        view.setupView(nameTextField)
        view.setupView(sumLabel)
        view.setupView(sumTextField)
        stackView.addArrangedSubview(expLabel)
        stackView.addArrangedSubview(switchExpOrinc)
        stackView.addArrangedSubview(incLabel)
        view.setupView(stackView)
        view.setupView(pickerViewIncOrExp)
        view.setupView(savButton)
        view.setupView(hideKeyboardButton)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            
            sumLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sumLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sumLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            
            sumTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sumTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            sumTextField.topAnchor.constraint(equalTo: sumLabel.bottomAnchor, constant: 10),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stackView.topAnchor.constraint(equalTo: sumTextField.bottomAnchor, constant: 10),
            
            pickerViewIncOrExp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            pickerViewIncOrExp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            pickerViewIncOrExp.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            
            savButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            savButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            savButton.topAnchor.constraint(equalTo: pickerViewIncOrExp.bottomAnchor, constant: 40),
            
            
            hideKeyboardButton.widthAnchor.constraint(equalToConstant: 100),
            view.keyboardLayoutGuide.topAnchor.constraint(equalToSystemSpacingBelow: hideKeyboardButton.bottomAnchor, multiplier: 1.0),
            view.keyboardLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: hideKeyboardButton.trailingAnchor, multiplier: 1.0)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        sumTextField.delegate = self
        nameTextField.delegate = self
        pickerViewIncOrExp.delegate = self
        
        let tapScreen = UITapGestureRecognizer(target: self,
                                               action: #selector(dismissKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
        
        switchExpOrinc.addTarget(self,
                                 action: #selector(toggelIncOrExp),
                                 for: .valueChanged)
        pickerViewIncOrExp.layer.cornerRadius = 17
        watchTheKeyboardChange()
        hideKeyboardButton.addTarget(self,
                                     action: #selector(dismissKeyboard),
                                     for: .touchUpInside)
        savButton.addTarget(self,
                            action: #selector(savButtonTaped),
                            for: .touchUpInside)
        tag = pickerViewIncOrExp.arratTag[0]
    }
}

extension CreateRowController {
    func watchTheKeyboardChange() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
}

extension CreateRowController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == UIColor.lightGray {
            textField.text = ""
            textField.textColor = R.Colors.titleGray
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if nameTextField.text == "" {
            nameTextField.textColor = .lightGray
            nameTextField.text = "Введите название операции..."
        }
        
        if sumTextField.text == "" {
            sumTextField.textColor = .lightGray
            sumTextField.text = "Введите сумму операции..."
        }
    }
}
