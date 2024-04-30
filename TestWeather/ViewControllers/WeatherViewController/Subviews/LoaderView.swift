//
//  LoaderView.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 30.04.2024.
//

import UIKit
//19°

class LoaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createSubviews()
    }
    
    private func createSubviews() {
        
        let path = UIBezierPath()
        path.addArc(withCenter: .zero, radius: 90, startAngle: 90, endAngle: 0, clockwise: true)
        
        let toPath = UIBezierPath()
        toPath.addArc(withCenter: .zero, radius: 90, startAngle: 180, endAngle: 0, clockwise: true)
        
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.red.cgColor
        layer.lineWidth = 20
        layer.lineCap = .round
        layer.position = .zero
        self.layer.addSublayer(layer)
        
        
        
        let animation = CABasicAnimation(keyPath: "path")
//        animation.fromValue = path.cgPath
        animation.toValue = toPath.cgPath
        animation.duration = 1.0
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .default)
        animation.fillMode = .forwards
        
        CATransaction.begin()
        layer.add(animation, forKey: "animateCircle")
        CATransaction.commit()
        
        
        
    }
    
}
