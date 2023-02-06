//
//  BatteryIcon.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/1/16.
//

import UIKit

class BatteryIcon: UIView {
    
    // MARK: - IBOutlet
    
    
    // MARK: - Variables
    
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        addXibView()
        // 電池灰色內圈
        let batteryCircleLayer = CAShapeLayer()
        batteryCircleLayer.frame = CGRect(x: 24.9, y: 26.5, width: 0, height: 0)
        // 填充色為透明
        batteryCircleLayer.fillColor = UIColor.clear.cgColor
        // 邊框寬度為 20
        batteryCircleLayer.lineWidth = 20
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
                                             radius: self.bounds.height * 0.4,
                                             startAngle: 0,
                                             endAngle: CGFloat(2 * Float.pi),
                                             clockwise: true)
        // 設定 Path 給 Layer
        batteryCircleLayer.path = batteryCirclePath.cgPath
        // 在 view 上面新增 Layer
        self.layer.addSublayer(batteryCircleLayer)
        
        // Transmitter 的綠色電量條
        let transmitterbatteryCircleLayer = CAShapeLayer()
        transmitterbatteryCircleLayer.frame = CGRect(x: 24.9, y: 26.5, width: 0, height: 0)
        transmitterbatteryCircleLayer.fillColor = UIColor.clear.cgColor
        transmitterbatteryCircleLayer.lineWidth = 20
        transmitterbatteryCircleLayer.strokeColor = UIColor.systemGreen.cgColor
        
        arcCenter = transmitterbatteryCircleLayer.position
        let transmitterbatteryCirclePath = UIBezierPath(arcCenter: arcCenter,
                                                        radius: self.bounds.height * 0.4,
                                                        startAngle: (CGFloat.pi / 180) * 270,
                                                        endAngle: (CGFloat.pi / 180) * 90,
                                                        clockwise: true)
        transmitterbatteryCircleLayer.path = transmitterbatteryCirclePath.cgPath
        self.layer.addSublayer(transmitterbatteryCircleLayer)
        
        // Scanner 的綠色電量條
        let scannerbatteryCircleLayer = CAShapeLayer()
        scannerbatteryCircleLayer.frame = CGRect(x: 24.9, y: 26.5, width: 0, height: 0)
        scannerbatteryCircleLayer.fillColor = UIColor.clear.cgColor
        scannerbatteryCircleLayer.lineWidth = 20
        scannerbatteryCircleLayer.strokeColor = UIColor.systemGreen.cgColor
        
        arcCenter = scannerbatteryCircleLayer.position
        let scannerBatteryCirclePath = UIBezierPath(arcCenter: arcCenter,
                                                    radius: self.bounds.height * 0.4,
                                                    startAngle: (CGFloat.pi / 180) * 270,
                                                    endAngle: (CGFloat.pi / 180) * 270,
                                                    clockwise: false)
        scannerbatteryCircleLayer.path = scannerBatteryCirclePath.cgPath
        self.layer.addSublayer(scannerbatteryCircleLayer)
        
        // 黑色外框
        let frameCircleLayer = CAShapeLayer()
        frameCircleLayer.frame = CGRect(x: 24.9, y: 26.5, width: 0, height: 0)
        frameCircleLayer.lineWidth = 1
        frameCircleLayer.strokeColor = UIColor.black.cgColor
        frameCircleLayer.fillColor = UIColor.clear.cgColor
        
        let frameCirclePath = UIBezierPath(arcCenter: arcCenter,
                                           radius: self.bounds.height * 0.5,
                                           startAngle: 0,
                                           endAngle: CGFloat(2 * Float.pi),
                                           clockwise: true)
        frameCircleLayer.path = frameCirclePath.cgPath
        self.layer.addSublayer(frameCircleLayer)
        
        // 黑色內框
        let innerFrameCircleLayer = CAShapeLayer()
        innerFrameCircleLayer.frame = CGRect(x: 24.9, y: 26.5, width: 0, height: 0)
        innerFrameCircleLayer.lineWidth = 1
        innerFrameCircleLayer.strokeColor = UIColor.black.cgColor
        innerFrameCircleLayer.fillColor = UIColor.clear.cgColor
        
        let innerFrameCirclePath = UIBezierPath(arcCenter: arcCenter,
                                                radius: self.bounds.height * 0.3,
                                                startAngle: 0,
                                                endAngle: CGFloat(2 * Float.pi),
                                                clockwise: true)
        innerFrameCircleLayer.path = innerFrameCirclePath.cgPath
        self.layer.addSublayer(innerFrameCircleLayer)
        
        
        // 黑色分隔線（上）
        let upperlineLayer = CAShapeLayer()
        upperlineLayer.frame = CGRect(x: 24.9, y: 26.5, width: 0, height: 0)
        upperlineLayer.lineWidth = 1
        upperlineLayer.strokeColor = UIColor.black.cgColor
        upperlineLayer.fillColor = UIColor.clear.cgColor
        
        // 設定 Path
        let upperlinePath = UIBezierPath()
        // 繪製線的起始點
        upperlinePath.move(to: CGPoint(x: 24.9, y: -23.9))
        // 繪製線的終點（再新增一個 addLine 會連接到新的點）
        upperlinePath.addLine(to: CGPoint(x:  24.9, y: -2.8))
        upperlineLayer.path = upperlinePath.cgPath
        self.layer.addSublayer(upperlineLayer)
        
        // 黑色分隔線（下）
        let lowerlineLayer = CAShapeLayer()
        lowerlineLayer.frame = CGRect(x: 24.9, y: 26.5, width: 0, height: 0)
        lowerlineLayer.lineWidth = 1
        lowerlineLayer.strokeColor = UIColor.black.cgColor
        lowerlineLayer.fillColor = UIColor.clear.cgColor
        
        let lowerlinePath = UIBezierPath()
        lowerlinePath.move(to: CGPoint(x: 24.9, y: 57))
        lowerlinePath.addLine(to: CGPoint(x:  24.9, y: 77))
        lowerlineLayer.path = lowerlinePath.cgPath
        self.layer.addSublayer(lowerlineLayer)
    }
    
    // view 在設計時想要看到畫面要用這個
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        addXibView()
    }
    
    // MARK: - UI Settings
    
    // MARK: - IBAction
}

// MARK: - Extensions

fileprivate extension BatteryIcon {
    // 加入畫面
    func addXibView() {
        if let loadView = Bundle(for: BatteryIcon.self)
            .loadNibNamed("BatteryIcon",
                          owner: self,
                          options: nil)?.first as? UIView {
            addSubview(loadView)
            loadView.frame = bounds
        }
    }
}



// MARK: - Protocol


