//
//  MMBaseController.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 05.11.2022.
//

import UIKit

enum Position {
    case left
    case right
}

class MMBaseController: UIViewController {
    
    func addingAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок",
                                   style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        constraintViews()
        configureAppearance()
    }
}

@objc extension MMBaseController {
    func setupViews() {}
    func constraintViews() {}
    func configureAppearance() {
        view.backgroundColor = R.Colors.background
    }
}


