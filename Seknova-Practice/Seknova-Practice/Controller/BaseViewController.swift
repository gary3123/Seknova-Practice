//
//  BaseViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/10/25.
//

import UIKit

class BaseViewController: UIViewController {
 
    //設定 Navigation Bar
    func setNavigationbar(backgroundcolor: UIColor?,
                          tintColor: UIColor? = .white,
                          foregroundColor: UIColor? = .white) {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = backgroundcolor
        self.navigationController?.navigationBar.tintColor = tintColor
        appearence.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : foregroundColor ?? .white
        ]
        
        self.navigationController?.navigationBar.standardAppearance = appearence
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearence
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    // 點擊螢幕收起鍵盤
    override  func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
