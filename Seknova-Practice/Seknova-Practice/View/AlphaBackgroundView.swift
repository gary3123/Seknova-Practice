//
//  AlphaBackgroundView.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/10/21.
//

import UIKit

class AlphaBackgroundView: UIView {
    
    // MARK: - Variables
    
    let fullScreenSize = UIScreen.main.bounds.size
    
    var imageView: UIImageView!
    
    // MARK: - LifeCycle
    
    init(imageName: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height))
        self.imageView = UIImageView(image: UIImage(named: imageName)) // "Background5.jpg"
        self.imageView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: fullScreenSize.width,
                                      height: fullScreenSize.height)
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.alpha = 0.2
        self.addSubview(self.imageView)
        self.insertSubview(self.imageView, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        // setAlphaBackground()
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
