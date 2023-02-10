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
        // 電池灰色內圈
        let batteryCircleLayer = CAShapeLayer()
        batteryCircleLayer.frame = CGRect(x: 20, y: 7, width: 0, height: 0)
        // 填充色為透明
        batteryCircleLayer.fillColor = UIColor.clear.cgColor
        // 邊框寬度為 20
        batteryCircleLayer.lineWidth = 6
        // 邊框顏色為灰色
        batteryCircleLayer.strokeColor = UIColor.systemGray.cgColor
        // 設定圓心
        var arcCenter: CGPoint = batteryCircleLayer.position
        /// UIBezierPath
        /// - Parameters:
        ///   - arcCenter: 圓心位置
        ///   - radius: 圓形半徑
        ///   - startAngle: 畫圓的起始角度 (CGFloat.pi / 180)  * 角度
        ///   - endAngle: 畫圓的結束角度 (CGFloat.pi / 180)  * 角度
        ///   - clockwise: 方向是否為順時鐘
        let batteryCirclePath = UIBezierPath(arcCenter: arcCenter,
                                             radius: view.bounds.height * 0.5,
                                             startAngle: 0,
                                             endAngle: CGFloat(2 * Float.pi),
                                             clockwise: true)
        // 設定 Path 給 Layer
        batteryCircleLayer.path = batteryCirclePath.cgPath
        // 在 view 上面新增 Layer
        view.layer.addSublayer(batteryCircleLayer)
        
        // Transmitter 的綠色電量條
        let transmitterbatteryCircleLayer = CAShapeLayer()
        transmitterbatteryCircleLayer.frame = CGRect(x: 20, y: 7, width: 0, height: 0)
        transmitterbatteryCircleLayer.fillColor = UIColor.clear.cgColor
        transmitterbatteryCircleLayer.lineWidth = 6
        transmitterbatteryCircleLayer.strokeColor = UIColor.systemGreen.cgColor
        
        arcCenter = transmitterbatteryCircleLayer.position
        let transmitterbatteryCirclePath = UIBezierPath(arcCenter: arcCenter,
                                                        radius: view.bounds.height * 0.5,
                                                        startAngle: (CGFloat.pi / 180) * 270,
                                                        endAngle: (CGFloat.pi / 180) * 90,
                                                        clockwise: true)
        transmitterbatteryCircleLayer.path = transmitterbatteryCirclePath.cgPath
        view.layer.addSublayer(transmitterbatteryCircleLayer)
        
        // Scanner 的綠色電量條
        let scannerbatteryCircleLayer = CAShapeLayer()
        scannerbatteryCircleLayer.frame = CGRect(x: 20, y: 7, width: 0, height: 0)
        scannerbatteryCircleLayer.fillColor = UIColor.clear.cgColor
        scannerbatteryCircleLayer.lineWidth = 6
        scannerbatteryCircleLayer.strokeColor = UIColor.systemGreen.cgColor
        
        arcCenter = scannerbatteryCircleLayer.position
        let scannerBatteryCirclePath = UIBezierPath(arcCenter: arcCenter,
                                                    radius: view.bounds.height * 0.5,
                                                    startAngle: (CGFloat.pi / 180) * 270,
                                                    endAngle: (CGFloat.pi / 180) * 270,
                                                    clockwise: false)
        scannerbatteryCircleLayer.path = scannerBatteryCirclePath.cgPath
        view.layer.addSublayer(scannerbatteryCircleLayer)
        
        // 黑色外框
        let frameCircleLayer = CAShapeLayer()
        frameCircleLayer.frame = CGRect(x: 20, y: 7, width: 0, height: 0)
        frameCircleLayer.lineWidth = 0.5
        frameCircleLayer.strokeColor = UIColor.black.cgColor
        frameCircleLayer.fillColor = UIColor.clear.cgColor
        
        let frameCirclePath = UIBezierPath(arcCenter: arcCenter,
                                           radius: view.bounds.height * 0.61,
                                           startAngle: 0,
                                           endAngle: CGFloat(2 * Float.pi),
                                           clockwise: true)
        frameCircleLayer.path = frameCirclePath.cgPath
        view.layer.addSublayer(frameCircleLayer)
        
        // 黑色內框
        let innerFrameCircleLayer = CAShapeLayer()
        innerFrameCircleLayer.frame = CGRect(x: 20, y: 7, width: 0, height: 0)
        innerFrameCircleLayer.lineWidth = 0.5
        innerFrameCircleLayer.strokeColor = UIColor.black.cgColor
        innerFrameCircleLayer.fillColor = UIColor.clear.cgColor
        
        let innerFrameCirclePath = UIBezierPath(arcCenter: arcCenter,
                                                radius: view.bounds.height * 0.37,
                                                startAngle: 0,
                                                endAngle: CGFloat(2 * Float.pi),
                                                clockwise: true)
        innerFrameCircleLayer.path = innerFrameCirclePath.cgPath
        view.layer.addSublayer(innerFrameCircleLayer)
        
        
        // 黑色分隔線（上）
        let upperlineLayer = CAShapeLayer()
        upperlineLayer.frame = CGRect(x: 15, y: 24, width: 0, height: 0)
        upperlineLayer.lineWidth = 0.5
        upperlineLayer.strokeColor = UIColor.black.cgColor
        upperlineLayer.fillColor = UIColor.clear.cgColor
        
        // 設定 Path
        let upperlinePath = UIBezierPath()
        // 繪製線的起始點
        upperlinePath.move(to: CGPoint(x: 24.9, y: -23.9))
        // 繪製線的終點（再新增一個 addLine 會連接到新的點）
        upperlinePath.addLine(to: CGPoint(x:  24.9, y: -18.2))
        upperlineLayer.path = upperlinePath.cgPath
        view.layer.addSublayer(upperlineLayer)
        
        // 黑色分隔線（下）
        let lowerlineLayer = CAShapeLayer()
        lowerlineLayer.frame = CGRect(x: 15, y: -34, width: 0, height: 0)
        lowerlineLayer.lineWidth = 0.5
        lowerlineLayer.strokeColor = UIColor.black.cgColor
        lowerlineLayer.fillColor = UIColor.clear.cgColor
        
        let lowerlinePath = UIBezierPath()
        lowerlinePath.move(to: CGPoint(x: 24.9, y: 57))
        lowerlinePath.addLine(to: CGPoint(x:  24.9, y: 62))
        lowerlineLayer.path = lowerlinePath.cgPath
        view.layer.addSublayer(lowerlineLayer)
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
