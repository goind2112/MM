//
//  MMBaseContainerView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 07.11.2022.
//

import UIKit

enum TextPosition {
    case left
    case right
    case center
    case collection
}

class MMBaseContainerView: MMBaseView {
    private var position: TextPosition?
    private var font: CGFloat?
    private let titelLabel: UILabel = {
        let ladel = UILabel()
        ladel.textColor = R.Colors.inactive
        return ladel
    }()
    
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = R.Colors.separator.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    init(with title: String? = nil, font: CGFloat? = nil, position: TextPosition? = nil){
        self.font = font
        self.position = position
        titelLabel.text = title
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
    
    func addTextPosition (with position: TextPosition?) -> NSTextAlignment {
        switch position {
        case .left: return NSTextAlignment(.left)
        case .right: return NSTextAlignment(.right)
        case .center: return NSTextAlignment(.center)
        case .collection: return NSTextAlignment(.left)
        case .none: return NSTextAlignment(.left)
        }
    }
}

extension MMBaseContainerView {
    override func setupViews() {
        super.setupViews()
        
        setupView(titelLabel)
        setupView(contentView)
    }
    override func constraintViews() {
        super.constraintViews()
        
        let contentTopAn: NSLayoutAnchor = titelLabel.text == nil ? topAnchor : titelLabel.bottomAnchor
        let contentOffset: CGFloat = titelLabel.text == nil ? 0 : 10
        let indentLabelCollection: CGFloat = position == .collection ? 10 : 0
        
        NSLayoutConstraint.activate([
            
            titelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: indentLabelCollection),
            titelLabel.topAnchor.constraint(equalTo: topAnchor),
            titelLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            contentView.topAnchor.constraint(equalTo: contentTopAn, constant: contentOffset),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        titelLabel.textAlignment = addTextPosition(with: position)
        titelLabel.font = R.Fonts.helveticaRegular(with: self.font ?? 13)
        backgroundColor = .clear
    }
}

