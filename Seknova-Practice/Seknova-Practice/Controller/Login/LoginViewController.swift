//
//  MainViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/10/13.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var accountTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - Variables
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationbar(backgroundcolor: .navigationBar)
        view.insertSubview(AlphaBackgroundView(imageName: "Background5.jpg"), at: 0)
        setupUI()
        self.title = "Login"
    }

    // MARK: - UI Settings
    
    func setupUI() {
        setupTextField()
    }
    
    private func setupTextField() {
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
    }
    
    // MARK: - IBAction
    
    // 設定跳轉到註冊的頁面
    @IBAction func TurnToRegisterViewController(_ sender: Any) {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}


