//
//  RigsterBackgroundView.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/10/27.
//

import UIKit

class RegisterBackgroundView: UIView {
    let fullScreenSize = UIScreen.main.bounds.size
    
    var imageView: UIImageView = UIImageView(image: UIImage(named: "Background.jpg"))
    
    override func prepareForInterfaceBuilder() {
        setAlphaBackground()
    }
    
    override func awakeFromNib() {
        setAlphaBackground()
    }
    
    func setAlphaBackground() {
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: fullScreenSize.width,
                                 height: fullScreenSize.height)
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.2
        self.addSubview(imageView)
        self.insertSubview(imageView, at: 0)
    }
}
