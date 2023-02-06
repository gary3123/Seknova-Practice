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
    
    var lastPage: LogingLastPage = .recertifictionVC
    enum LogingLastPage {
        case qrCodeVC
        case recertifictionVC
        case persionalInformationVC
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
        setNavigationbar(backgroundcolor: .navigationBar)
        view.insertSubview(AlphaBackgroundView(imageName: "Background5.jpg", alpha: 0.2), at: 0)
        setupUI()
        self.title = "Login"
        
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
        
        //設定 TextField 的樣式
        textfieldStackView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
        textfieldStackView.layer.cornerRadius = 5
        
        // 判斷前一頁是由哪裡切進來的，如果是註冊信，則自動填好帳密，如果是 QR code 則清空帳密
        switch lastPage {
        case .recertifictionVC:
            accountTextfield.text = UserPreferences.shared.email
            passwordTextfield.text = UserPreferences.shared.password
            print("從註冊信進來")
        case .qrCodeVC:
            accountTextfield.text = ""
            passwordTextfield.text = ""
            print("從 QR code 掃描頁面進來")
        case .persionalInformationVC:
            accountTextfield.text = ""
            passwordTextfield.text = ""
            print("從 PersionalInformation 頁面進來")
        }
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
                    let nextVC = ContrastPopoverViewController()
                    self.navigationController?.pushViewController(nextVC, animated: true)
                } else {
                    let nextVC = MainViewController()
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
            }
            // 登入之後先建立校正模式的 Realm 表，以及設定的預設值
            UserPreferences.shared.showNumericalInformation = true
            UserPreferences.shared.uploadCloud = true
            let addData = CalibrationModeDataTable(modeID: 0,
                                                   rawData2BGBias: 100,
                                                   BGBias: 100,
                                                   BGLow: 40,
                                                   BGHigh: 400,
                                                   mapRate: 1,
                                                   thresholdRise: 50,
                                                   thresholdFall: 50,
                                                   riseRate: 100,
                                                   fallenRate: 100)
            LocalDatabase.shared.addCalibrationModeData(calibrationModeData: addData)
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




