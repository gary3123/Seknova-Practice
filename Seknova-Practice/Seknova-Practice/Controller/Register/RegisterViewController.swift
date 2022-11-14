//
//  RegisterViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/10/21.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var againPasswordTextfield: UITextField!
    @IBOutlet weak var cuntryLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cuntryPickerView: UIPickerView!
    @IBOutlet weak var contrastButton: UIButton!
    // MARK: - Variables
    let cuntryArray = ["Taiwan(台灣)","China(中國)","America(美國)","Japan(日本)"]
    var contrastStatus = false
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(AlphaBackgroundView(imageName: "Background.jpg"), at: 0)
        setupUI()
        self.title = "Register"
    }

    
    // MARK: - UI Settings

    func setupUI() {
        setupTextfield()
        setupPickerView()
        setupLabel()
    }
    
    func setupLabel() {
        // 開啟 Label 交互功能
        cuntryLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapLabel))
        cuntryLabel.addGestureRecognizer(tap)
    }
    
    func setupPickerView() {
        cuntryPickerView.delegate = self
        cuntryPickerView.dataSource = self
    }
    
    fileprivate func setupTextfield() {
        emailTextfield.setTextFieldImage(imageName: "mail",
                                         imageX: 9 ,
                                         imageY: 10,
                                         imageWidth: 30,
                                         imageheight: 20)
        passwordTextfield.setTextFieldImage(imageName: "password",
                                            imageX: 12 ,
                                            imageY: 3,
                                            imageWidth: 25,
                                            imageheight: 30)
        againPasswordTextfield.setTextFieldImage(imageName: "password",
                                                 imageX: 12 ,
                                                 imageY: 3,
                                                 imageWidth: 25,
                                                 imageheight: 30)
    }
    //設定同意書的按鈕格式及顏色
    func setContrastButton ( tintColor: UIColor ) {
        var configuration = UIButton.Configuration.filled()
        configuration.background.strokeColor = .darkGray
        configuration.background.strokeWidth = 2
        configuration.background.strokeOutset = 5
        configuration.background.cornerRadius = 20
        contrastButton.configuration = configuration
        contrastButton.tintColor = tintColor
    }
    
    // MARK: - IBAction
    
    @objc func tapLabel() {
        print("tap label")
        cuntryPickerView.isHidden = false
        registerButton.isHidden = true
    }

    @IBAction func contrastClick(_ sender: Any) {
        if contrastStatus == false {
            contrastStatus = true
            setContrastButton(tintColor: .systemBlue)
        }
        else {
            contrastStatus = false
            setContrastButton(tintColor: .white)
        }
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        var alertMessageArray :[String] = []
        var alertMessageString = ""
        if emailTextfield.text!.validate(type: .email) {
            
        } else {
            alertMessageArray.append("電子信箱格式錯誤")
        }
        
        if passwordTextfield.text!.validate(type: .password) {
            
        }else {
            alertMessageArray.append("密碼格式錯誤")
        }
        
        if againPasswordTextfield.text != passwordTextfield.text {
            alertMessageArray.append("密碼不一致")
        }
        if contrastStatus == false {
            alertMessageArray.append("未勾選同意書")
        }
        
        for i in 0...alertMessageArray.count-1 {
            alertMessageString.append("\(alertMessageArray[i])")
            if i != alertMessageArray.count-1 {
                alertMessageString.append("\n")
            }
        }
        
        Alert.showAlertWith(title: "註冊格式錯誤",
                            message: alertMessageString,
                            vc: self,
                            confirmTitle: "關閉")
        
    }
    
}

    // MARK: - extension
extension RegisterViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cuntryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cuntryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cuntryLabel.text = cuntryArray[row]
        cuntryPickerView.isHidden = true
        registerButton.isHidden = false
    }
}


