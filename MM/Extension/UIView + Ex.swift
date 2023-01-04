//
//  UIView + Ex.swift
//  MM
//
//  Created by Даниил Мухсинятов on 31.12.2022.
//

import Foundation
import UIKit

extension UIView {
    func addingBottomBorder(with color: UIColor, height: CGFloat) {
        let separator = UIView()
        
        separator.backgroundColor = color
        separator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        separator.frame = CGRect(x: 0,
                                 y: frame.height - height,
                                 width: frame.width,
                                 height: height)
        addSubview(separator)
    }
    
    func setupView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
