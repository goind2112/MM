//
//  ProgressBarView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 09.11.2022.
//

import UIKit

extension PathToTheGoalView {
    final class ProgressBarView: UIView {
        
        func drawProgress (with percent: CGFloat) {
            layer.sublayers?.removeAll()
            
            let startDraw = UIScreen.main.bounds.minX + 25
            let heightDraw = UIScreen.main.bounds.height / 11
            let andDraw = UIScreen.main.bounds.maxX - 80
            
            let startDrawPoint = CGPoint(x: startDraw, y: heightDraw)
            let andDrawPoint = CGPoint(x: andDraw, y: heightDraw)
            
            let lineDraw = UIBezierPath()
            lineDraw.move(to: startDrawPoint)
            lineDraw.addLine(to: andDrawPoint)
            
            let defaultLineLayer = CAShapeLayer()
            defaultLineLayer.path = lineDraw.cgPath
            defaultLineLayer.strokeColor = R.Colors.inactive.cgColor
            defaultLineLayer.lineWidth = 20
            defaultLineLayer.strokeEnd = 1
            defaultLineLayer.fillColor = UIColor.clear.cgColor
            defaultLineLayer.lineCap = .round
            
            let lineLayer = CAShapeLayer()
            lineLayer.path = lineDraw.cgPath
            lineLayer.strokeColor = R.Colors.active.cgColor
            lineLayer.lineWidth = 20
            lineLayer.strokeEnd = percent
            lineLayer.fillColor = UIColor.clear.cgColor
            lineLayer.lineCap = .round
            
            let defaultLayer = CAShapeLayer()
            defaultLayer.path = lineDraw.cgPath
            defaultLayer.strokeColor = R.Colors.active.cgColor
            defaultLayer.lineWidth = 20
            defaultLayer.strokeEnd = 0.001
            defaultLayer.fillColor = UIColor.clear.cgColor
            defaultLayer.lineCap = .round
            
            layer.addSublayer(defaultLineLayer)
            layer.addSublayer(lineLayer)
            layer.addSublayer(defaultLayer)
        }
    }
}
