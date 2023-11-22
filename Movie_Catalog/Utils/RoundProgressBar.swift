//
//  RoundProgressBar.swift
//  Movie_Catalog
//
//  Created by José Javier Romero on 22/11/23.
//

import UIKit


class RoundProgressBar: UIView {
    
    private let progressLayer = CAShapeLayer()
    private let gradeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let circularPath = UIBezierPath(arcCenter: centerPoint, radius: bounds.width / 2, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.black.cgColor
        
        let hexColor = "#0D1C21"
        if let convertedColor = UIColor(hex: hexColor)?.cgColor {
            progressLayer.fillColor = convertedColor
        } else {
            progressLayer.fillColor = UIColor.clear.cgColor
        }
        
        progressLayer.lineWidth = 3
        progressLayer.lineCap = .round
        
        layer.addSublayer(progressLayer)
        
        // Configure rating label
        gradeLabel.frame = bounds
        gradeLabel.textAlignment = .center
        gradeLabel.textColor = UIColor.white
        gradeLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        addSubview(gradeLabel)
    }
    
    func setProgress(_ progress: Float) {
        // Normalize the rating between 0 and 10 and divide by 10 to calculate the uncolored part of the circle.
        let normalizedProgress = max(0, min(progress, 10)) / 10
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = normalizedProgress
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        progressLayer.strokeEnd = CGFloat(normalizedProgress)
        progressLayer.add(animation, forKey: "animateProgress")
        
        
        // We format the text to have only 2 decimal places in the rating
        gradeLabel.text = String(format: "%.2f", progress)
        
        
        if normalizedProgress <= 0.5 {
            progressLayer.strokeColor = UIColor.red.cgColor
        } else if normalizedProgress > 0.5 && normalizedProgress <= 0.8 {
            progressLayer.strokeColor = UIColor.yellow.cgColor
        } else{
            progressLayer.strokeColor = UIColor.green.cgColor
            
        }
        
    }
}
