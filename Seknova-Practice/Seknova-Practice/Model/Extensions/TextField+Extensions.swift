//
//  TextField+Extensions.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/10/26.
//

import UIKit

extension UITextField {
    
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
    

}
