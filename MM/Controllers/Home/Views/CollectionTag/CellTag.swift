//
//  CellTeg.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 24.11.2022.
//

import UIKit


class FaceItemTag {
    var array = [ItemTag]()
    
    func addArray (array: [ItemTag], condition: TypeOfOperation) {
        for income in array {
            if income.condition == condition {
                self.array.append(income)
            } 
        }
    }
    struct ItemTag {
        var tag: String
        var emoji: String
        var value: String
        var condition: TypeOfOperation
    }
}

final class CellTag: UICollectionViewCell {
    
    private enum Constants {
        static let indent: CGFloat = 15
        static let lableHeight: CGFloat = 20
        static let lableEmoji: CGFloat = 40
    }
    
    let tagEmojiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = R.Fonts.helveticaRegular(with: 40)
        return label
    }()
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = R.Colors.titleGray
        label.font = R.Fonts.helveticaRegular(with: 17)
        return label
    }()
    
    let tagValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = R.Colors.titleGray
        label.font = R.Fonts.helveticaRegular(with: 13)
        return label
    }()
    
    private let containerView: UIView = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView.addSubview(tagLabel)
        containerView.addSubview(tagEmojiLabel)
        containerView.addSubview(tagValueLabel)
        contentView.addSubview(containerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let containerWibth = contentView.bounds.width - 2 * Constants.indent
        
        tagEmojiLabel.frame = .init(x: 0,
                                    y: 0,
                               width: containerWibth,
                               height: Constants.lableEmoji)
        
        tagLabel.frame = .init(x: 45,
                               y: 0,
                               width: containerWibth - 45,
                               height: Constants.lableHeight)
        
        tagValueLabel.frame = .init(x: 45,
                               y: 15,
                               width: containerWibth - 45,
                               height: Constants.lableHeight)
        
        let contentHeight = CGFloat(40)
        
        containerView.frame = .init(x: 5,
                                    y: contentView.bounds.height / 2 - contentHeight/2,
                                    width: containerWibth,
                                    height: contentHeight)
    }
    
    
}

