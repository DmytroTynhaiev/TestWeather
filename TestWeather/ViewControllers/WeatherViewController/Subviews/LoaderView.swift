//
//  LoaderView.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 30.04.2024.
//

import UIKit

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
        self.addCircle(0)
        self.addCircle(1)
        self.addCircle(2)
    }
    
    
    func addCircle(_ index: Int) {
        let path = UIBezierPath()
        path.addArc(withCenter: .zero, radius: 90, startAngle: 0, endAngle: .pi * 2, clockwise: true)
                
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.white.withAlphaComponent(0.3).cgColor
        layer.strokeEnd = 0
        layer.lineWidth = 20
        layer.lineCap = .round
        self.layer.addSublayer(layer)
        
        let startAnimation = CAKeyframeAnimation()
        startAnimation.keyPath = "strokeEnd"
        startAnimation.values = [0.001, 1, 1]
        startAnimation.keyTimes = [0, 0.5, 1]
        
        let endAnimation = CAKeyframeAnimation()
        endAnimation.keyPath = "strokeStart"
        endAnimation.values = [0.001, 0.001, 1]
        endAnimation.keyTimes = [0, 0.5, 1]
        
        let group = CAAnimationGroup()
        group.duration = 2.0
        group.repeatCount = .infinity
        group.beginTime = CACurrentMediaTime() + Double(index) / 8
        group.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        group.animations = [startAnimation, endAnimation]
        
        layer.add(group, forKey: "animateCircle\(index)")
    }
    
}
