//
//  Alert.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/3.
//

import UIKit

class Alert {
    
    
    
    
    static func showAlertWith(title: String,
                              message: String,
                              vc: UIViewController,
                              confirmTitle: String,
                              confirm: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { action in
                confirm?()
            }
            alertController.addAction(confirmAction)
            vc.present(alertController, animated: true)
        }
    }
    
    static func showAlertWith(title: String,
                              message: String,
                              vc: UIViewController,
                              confirmTitle: String,
                              cancelTitle: String,
                              confirm: (() -> Void)? = nil,
                              cancel: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { action in
                confirm?()
            }
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { action in
                cancel?()
            }
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            vc.present(alertController, animated: true)
        }
    }
}
