//
//  MMPresentationController.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 03.12.2022.
//

import UIKit

class PresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let halfHeight = bounds.height / 3
        return CGRect(x: 10,
                             y: halfHeight,
                             width: bounds.width - 20,
                             height: halfHeight)
    }
    
    override func presentationTransitionWillBegin() {
            super.presentationTransitionWillBegin()
            containerView?.addSubview(presentedView!)
        }
    
    override func containerViewDidLayoutSubviews() {
            super.containerViewDidLayoutSubviews()
            presentedView?.frame = frameOfPresentedViewInContainerView
        }
}
