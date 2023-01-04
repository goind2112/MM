//
//  MMBaseView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 07.11.2022.
//

import UIKit

class MMBaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        constraintViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc extension MMBaseView {
    func setupViews() {}
    func constraintViews() {}
    
    func configureAppearance() {
        backgroundColor = .white
    }
}

extension MMBaseController {
    
//    class NavBarButton: UIButton {
//        override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//            let margin: CGFloat = 55
//                let area = self.bounds.insetBy(dx: -margin, dy: -margin)
//                return area.contains(point)
//        }
//    }
//
    func addNavBarButton (at position: Position, with title: String?, image: UIImage?) -> UIButton {
        let button = UIButton(type: .system)
        
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
        button.setTitleColor(R.Colors.active, for: .normal)
        button.setTitleColor(R.Colors.inactive, for: .disabled)
        button.titleLabel?.font = R.Fonts.helveticaRegular(with: 17)
       
        switch position {
            
        case .left:
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
            return button
        case .right:
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
            guard let customView = navigationItem.rightBarButtonItem?.customView else { return button}
            customView.translatesAutoresizingMaskIntoConstraints = true
            NSLayoutConstraint.activate([
                customView.heightAnchor.constraint(equalToConstant: 44),
                customView.widthAnchor.constraint(equalToConstant: 44)
            ])
            return button
        }
    }
}
