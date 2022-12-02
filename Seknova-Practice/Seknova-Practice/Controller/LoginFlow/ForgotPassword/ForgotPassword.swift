//
//  ForgotPassword.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/21.
//

import UIKit

class ForgotPassword: BaseViewController {
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendOutButton: UIButton!
    
    // MARK: - Variables


    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationbar(backgroundcolor:  .navigationBar)
        view.insertSubview(AlphaBackgroundView(imageName: "Background.jpg", alpha: 0.2), at: 0)
        self.title = "Forgot Password"
        emailTextField.setBottomBorder()
        
        
    }

    // MARK: - UI Settings
    
    
    // MARK: - IBAction

    @IBAction func clickSendOut(_ sender: Any) {
        if emailTextField.text == UserPreferences.shared.email {
            let resetPasswordVC = ResetPasswordViewController()
            navigationController?.pushViewController(resetPasswordVC, animated: true)
        }else {
            Alert.showAlertWith(title: "信箱錯誤", message: "", vc: self, confirmTitle: "確認")
        }
       
    }
    
}

// MARK : - Extension
