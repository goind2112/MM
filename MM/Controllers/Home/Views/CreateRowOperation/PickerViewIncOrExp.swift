//
//  PickerViewIncOrExp.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 06.12.2022.
//

import UIKit

final class PickerViewIncOrExp: MMBaseView {
    weak var delegate: TagTransfer?
    
    var condition: TypeOfOperation = .expenses
    var arratTag = HomeViewController.arrayTagExp
    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.layer.cornerRadius = 15
        return picker
    }()
}

extension PickerViewIncOrExp {
    
    override func setupViews() {
        super.setupViews()
        setupView(pickerView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
}

extension PickerViewIncOrExp: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arratTag.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let row = arratTag[row]
        return PickerRow.setupPickerRow(with: row.emoji ?? "E", tagLabel: row.name ?? "Error")
    }
}

extension PickerViewIncOrExp: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let row = arratTag[row]
            delegate?.tagTransfer(with: row)
    }
}

