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
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            
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
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            
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
    
    static func showAlertWith(title: String,
                              message: String,
                              vc: UIViewController ,
                              confirmtitle: String,
                              canceltitle: String,
                              setTextField: ((UITextField) -> Void)?,
                              confirm: ((UITextField) -> Void)?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            alertController.addTextField { textfield in
                setTextField?(textfield)
            }
            
            let confirmAction = UIAlertAction(title: confirmtitle, style: .default) { action in
                let textField = (alertController.textFields?.first)! as UITextField
                confirm?(textField)
            }
            
            let cancel = UIAlertAction(title: canceltitle, style: .default)
            
            alertController.addAction(cancel)
            alertController.addAction(confirmAction)
            
            vc.present(alertController, animated: true)
        }
    }
    
    static func showActionSheet(array: [String],
                                canceltitle: String,
                                vc: UIViewController,
                                confirm: ((Int) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil,
                                                    message: nil,
                                                    preferredStyle: .actionSheet)
            
            for option in array {
                let action = UIAlertAction(title: option, style: .default) { action in
                    let index = array.firstIndex(of: option)
                    confirm?(index!)
                }
                action.setValue(UIColor.navigationBar!, forKey: "titleTextColor")
                alertController.addAction(action)
            }
            let cancelAction = UIAlertAction(title: canceltitle, style: .cancel)
            cancelAction.setValue(UIColor.navigationBar!, forKey: "titleTextColor")
            alertController.addAction(cancelAction)
            vc.present(alertController,animated: true)
        }
    }
}
