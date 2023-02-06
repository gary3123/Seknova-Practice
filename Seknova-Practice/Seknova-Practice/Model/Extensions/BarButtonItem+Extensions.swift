//
//  BarButtonItem+Extensions.swift
//  Seknova-Practice
//
//  Created by Gary on 2022/12/28.
//

import UIKit

//extension UIBarButtonItem {
//    func setBarButtonItem(imageName: String,
//                          width: Int,
//                          height: Int,
//                          setfunc: () -> Void) {
//        let buttonItem = UIButton(type: .custom)
//        buttonItem.setImage(UIImage(named: imageName), for: .normal)
//        buttonItem.setTitle("", for: .normal)
//        buttonItem.addTarget(self, action: #selector(setfunc()), for: .touchUpInside)
//        let buttonView = UIBarButtonItem(customView: buttonItem)
//        // 設定寬
//        let currWidth = buttonView.customView?.widthAnchor.constraint(equalToConstant: CGFloat(width))
//        currWidth?.isActive = true
//        // 設定高
//        let currHeight = buttonView.customView?.heightAnchor.constraint(equalToConstant: height)
//        currHeight?.isActive = true
//        
//        self.navigationItem.leftBarButtonItem = buttonView
//        _ = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
//                                    target: nil, action: nil)
//        barButtonItem.append(buttonView)
//        //把設定好的 View 放進 Navigation 裏面
//        navigationItem.leftBarButtonItems = barButtonItem
//        setNavigationbar(backgroundcolor: .navigationBar!)
//        
//    }
//}
