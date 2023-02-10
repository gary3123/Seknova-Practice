//
//  TextField+Extensions.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/10/26.
//

import UIKit

extension UITextField {
    
    // 設定 TextField 圖標
    func setTextFieldImage(imageName: String,
                           imageX: Int,
                           imageY: Int,
                           imageWidth: Int,
                           imageheight: Int) {
        let imageView = UIImageView(frame: CGRect(x:imageX, y: imageY, width: imageWidth, height: imageheight))
        imageView.image = UIImage(named: imageName)
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageViewContainerView.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        leftView = imageViewContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
    
    // 設定 TextField 的樣式為底線
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.navigationBar?
            .cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
    }
    
    func setTextFieldRightView(SystemImageName: String,
                               color: UIColor,
                               imageX: CGFloat,
                               imageY: CGFloat,
                               rightViewMode: UITextField.ViewMode) {
        let view = UIView(frame: CGRect(x: 0, y: 0 , width: 20, height: 20))
        
        let imageView = UIImageView(image: UIImage(systemName: "SystemImageName", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.lightGray])))
        imageView.frame.origin.x = imageX
        imageView.frame.origin.y = imageY
        view.addSubview(imageView)
        self.rightView = view
        self.rightViewMode = rightViewMode
    }
}
