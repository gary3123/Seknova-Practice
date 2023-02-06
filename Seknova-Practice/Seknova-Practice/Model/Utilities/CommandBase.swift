//
//  CommandBase.swift
//  Seknova-Practice
//
//  Created by Gary on 2022/12/30.
//

import UIKit

class CommandBase: NSObject {
    
    static let sharedInstance = CommandBase()
    
    func drawCircle(in view: UIView) {
        let batteryCircleLayer = CAShapeLayer()
        batteryCircleLayer.frame = CGRect(x: 24.9, y: 26.5, width: 0, height: 0)
        batteryCircleLayer.fillColor = UIColor.systemGreen.cgColor
        batteryCircleLayer.lineWidth = 1
        batteryCircleLayer.strokeColor = UIColor.black.cgColor
        
        let arcCenter: CGPoint = batteryCircleLayer.position
        let batteryCirclePath = UIBezierPath(arcCenter: arcCenter,
                                radius: view.bounds.height * 0.5,
                                startAngle: 0,
                                endAngle: CGFloat(2 * Float.pi),
                                clockwise: true)
        batteryCircleLayer.path = batteryCirclePath.cgPath
        view.layer.addSublayer(batteryCircleLayer)
        
        let lineLayer = CAShapeLayer()
        lineLayer.frame = CGRect(x: 24.9, y: 26.5, width: 0, height: 0)
        lineLayer.lineWidth = 1
        lineLayer.strokeColor = UIColor.black.cgColor
        
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x:24.9, y: -23))
        linePath.addLine(to: CGPoint(x: 24.9, y: 77))
        lineLayer.path = linePath.cgPath
        view.layer.addSublayer(lineLayer)
        
        
        let innerCircleLayer = CAShapeLayer()
        innerCircleLayer.frame = CGRect(x: 24.9, y: 26.5, width: 0, height: 0)
        innerCircleLayer.fillColor = UIColor.white.cgColor
        innerCircleLayer.lineWidth = 1
        innerCircleLayer.strokeColor = UIColor.black.cgColor
        
        let innerCirclePath = UIBezierPath(arcCenter: arcCenter,
                                radius: view.bounds.height * 0.3,
                                startAngle: 0,
                                endAngle: CGFloat(2 * Float.pi),
                                clockwise: true)
        innerCircleLayer.path = innerCirclePath.cgPath
        view.layer.addSublayer(innerCircleLayer)
    }
    
    
    func drawBatteryIcon(in view: UIView) -> UIView {
        let batteryIcon = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: view.frame.width,
                                               height: view.frame.height))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        shapeLayer.fillColor = UIColor.orange.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = UIColor.black.cgColor
        let arcCenter:CGPoint = shapeLayer.position // 設定圓心let radius:CGFloat = 100 // 設定半徑
        // 剩下沒設置到的參數就為起始角度跟結束角度，最後為是否順時針
        let path = UIBezierPath(arcCenter: arcCenter, radius: batteryIcon.bounds.height * 0.2, startAngle: 0, endAngle: CGFloat(2 * Float.pi), clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.position = batteryIcon.center
        batteryIcon.layer.addSublayer(shapeLayer)
        return batteryIcon
    }
    
}
