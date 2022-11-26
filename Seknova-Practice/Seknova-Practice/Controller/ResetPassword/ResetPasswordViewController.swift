//
//  ResetPasswordViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/22.
//

import UIKit

class ResetPasswordViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var againPasswordTextField: UITextField!
    
    // MARK: - Variables
    
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationbar(backgroundcolor:  .navigationBar)
        view.insertSubview(AlphaBackgroundView(imageName: "Background.jpg"), at: 0)
        setupUI()
    }

    
    // MARK: - UI Settings
    
    func setupUI() {
        setupTextField()
    }
    
    private func setupTextField() {
        emailTextField.setTextFieldImage(imageName: "mail",
                                         imageX: 9 ,
                                         imageY: 10,
                                         imageWidth: 30,
                                         imageheight: 20)
       oldPasswordTextField.setTextFieldImage(imageName: "password",
                                            imageX: 12 ,
                                            imageY: 3,
                                            imageWidth: 25,
                                            imageheight: 30)
        newPasswordTextField.setTextFieldImage(imageName: "password",
                                               imageX: 12 ,
                                               imageY: 3,
                                               imageWidth: 25,
                                               imageheight: 30)
        againPasswordTextField.setTextFieldImage(imageName: "password",
                                                 imageX: 12 ,
                                                 imageY: 3,
                                                 imageWidth: 25,
                                                 imageheight: 30)
        
    }
    
    // MARK: - IBAction
    
    @IBAction func clickSendOut(_ sender: Any) {
        var alertMessageArray: [String] = []
        var alertMessageString = ""
        
        // 判斷密碼是否符合以及格式是否正確
        if emailTextField.text! != UserPreferences.shared.email {
            alertMessageArray.append("電子信箱錯誤")
        }
        
        if oldPasswordTextField.text! != UserPreferences.shared.password  {
            alertMessageArray.append("密碼錯誤")
        }
        
        if !(newPasswordTextField.text!.validate(type: .password)) {
            alertMessageArray.append("密碼格式錯誤")
        }
        
        if againPasswordTextField.text != newPasswordTextField.text {
            alertMessageArray.append("密碼不一致")
        }
        
        for i in 0 ..< alertMessageArray.count {
            alertMessageString.append("\(alertMessageArray[i])")
            if i != alertMessageArray.count-1 {
                alertMessageString.append("\n")
            }
        }
        
        if alertMessageString == "" {
            UserPreferences.shared.password = newPasswordTextField.text ?? oldPasswordTextField.text!
            Alert.showAlertWith(title: "更改密碼成功",
                                message: "",
                                vc: self,
                                confirmTitle: "確認") {
                self.navigationController?.popToRootViewController(animated: true)
            }
        } else {
            Alert.showAlertWith(title: "帳號密碼或更改格式錯誤",
                                message: alertMessageString,
                                vc: self,
                                confirmTitle: "確認")
        }
        
        
    }
    
   

}

// MARK: - Extension
