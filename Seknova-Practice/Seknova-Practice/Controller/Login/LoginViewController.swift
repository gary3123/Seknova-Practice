//
//  MainViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/10/13.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var textfieldStackView: UIStackView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var accountTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    var registerStatus = false
    var firstLoginStatus = false
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationbar(backgroundcolor: .navigationBar)
        view.insertSubview(AlphaBackgroundView(imageName: "Background5.jpg", alpha: 0.2), at: 0)
        setupUI()
        self.title = "Login"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 如果已經有註冊或登入過帳號的話，會自動把帳密打進 TextField
        accountTextfield.text = UserPreferences.shared.email
        passwordTextfield.text = UserPreferences.shared.password
    }

    // MARK: - UI Settings
    
    func setupUI() {
        setupTextField()
    }
    
    private func setupTextField() {
        // 設定 TextField 圖標
        accountTextfield.setTextFieldImage(imageName: "mail",
                                           imageX: 15,
                                           imageY: 15,
                                           imageWidth: 17,
                                           imageheight: 12)
        
        passwordTextfield.setTextFieldImage(imageName: "password",
                                            imageX: 16,
                                            imageY: 13,
                                            imageWidth: 13,
                                            imageheight: 15)
        // 設定密碼為黑點
        passwordTextfield.isSecureTextEntry = true
        
        //
        textfieldStackView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
        textfieldStackView.layer.cornerRadius = 5
    }
    
    // MARK: - IBAction
    
    // 設定跳轉到註冊的頁面
    @IBAction func clickRegister(_ sender: Any) {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    // 登入
    @IBAction func clickLogin(_ sender: Any) {
        
        if accountTextfield.text == UserPreferences.shared.email &&
            passwordTextfield.text == UserPreferences.shared.password {
            // 載入畫面運作
            loadingActivity.startAnimating()
            // 載入持續4秒
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
               self.loadingActivity.stopAnimating()
                if UserPreferences.shared.firstLogin == true {
                    UserPreferences.shared.firstLogin = false
                    self.navigationController?.pushViewController(ContrastPopoverViewController(), animated: true)
                }
            }
        } else {
            Alert.showAlertWith(title: "帳號或密碼錯誤",
                                message: "您輸入的帳號或密碼有誤\n請重新輸入",
                                vc: self,
                                confirmTitle: "確認")
        }
    }
    
    // 忘記密碼跳轉
    @IBAction func clickForgotPassword(_ sender: Any) {
        let forgotPasswordVC = ForgotPassword()
        navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
}




