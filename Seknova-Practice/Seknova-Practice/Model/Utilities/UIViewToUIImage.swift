//
//  UIViewToUIImage.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/1/16.
//

import Foundation
import UIKit

class UIViewToUIImage: NSObject {
    
    func UIViewToUIImage(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size,
                                               false,
                                               UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

