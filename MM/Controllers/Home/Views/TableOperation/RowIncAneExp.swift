//
//  RowIncAneExp.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 27.11.2022.
//

import UIKit

struct Item {
    var tag: String
    var emoji: String
    var value: String
    var name: String
    var condition: TypeOfOperation
}

final class RowIncAneExp: UITableViewCell {

    let emojiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = R.Fonts.helveticaRegular(with: 35)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = R.Colors.titleGray
        label.font = R.Fonts.helveticaRegular(with: 13)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = R.Fonts.helveticaRegular(with: 15)
        return label
    }()
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.Colors.titleGray
        label.textAlignment = .right
        label.font = R.Fonts.helveticaRegular(with: 13)
        return label
    }()
    
    let viewLine = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(emojiLabel)
        addSubview(nameLabel)
        addSubview(valueLabel)
        addSubview(tagLabel)
        addSubview(viewLine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rowWidth = UIScreen.main.bounds.width
        let viewHeight = contentView.bounds.height
        
        viewLine.frame = .init(x: 0,
                               y: 0,
                               width: 5,
                               height: viewHeight)
        
        emojiLabel.frame = .init(x: 10,
                                 y: 3,
                                 width: 40,
                                 height: 40)
        
        nameLabel.frame = .init(x: 55,
                                 y: 25,
                                 width: rowWidth - 55,
                                 height: 14)
        
        valueLabel.frame = .init(x: 55,
                                 y: 10,
                                 width: rowWidth/2 - 30,
                                 height: 14)
        
        tagLabel.frame = .init(x: rowWidth/2 - 10 + 40,
                                 y: 10,
                                 width: rowWidth/2 - 40,
                                 height: 14)
    }
}

