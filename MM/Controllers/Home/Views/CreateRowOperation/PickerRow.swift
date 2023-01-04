//
//  PickerRow.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 06.12.2022.
//

import UIKit

final class PickerRow: MMBaseView {
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = R.Fonts.helveticaRegular(with: 23)
        return label
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = R.Colors.titleGray
        label.font = R.Fonts.helveticaRegular(with: 23)
        return label
    }()
    
    static func setupPickerRow(with emojiLabel: String, tagLabel: String) -> PickerRow {
        let pickerRow = PickerRow()
        pickerRow.emojiLabel.text = emojiLabel
        pickerRow.tagLabel.text = tagLabel
        return pickerRow
    }
}

extension PickerRow {
    override func setupViews() {
        super.setupViews()
        setupView(emojiLabel)
        setupView(tagLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            emojiLabel.topAnchor.constraint(equalTo: topAnchor),
            emojiLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            emojiLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            emojiLabel.trailingAnchor.constraint(equalTo: emojiLabel.leadingAnchor, constant: 24),
            
            tagLabel.topAnchor.constraint(equalTo: topAnchor),
            tagLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            tagLabel.leadingAnchor.constraint(equalTo: emojiLabel.trailingAnchor, constant: 5),
            tagLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
    }
}
