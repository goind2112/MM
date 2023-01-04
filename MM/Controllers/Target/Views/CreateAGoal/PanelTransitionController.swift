//
//  MMPanelTransition.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 03.12.2022.
//

import UIKit

class PanelTransitionController: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmPresentationController(presentedViewController: presented,
                                      presenting: presenting ?? source)
    }
}
