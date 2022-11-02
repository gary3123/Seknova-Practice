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
    
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextfield()
        // 開啟 Label 交互功能
        cuntryLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapLabel))
        cuntryLabel.addGestureRecognizer(tap)
        cuntryPickerView.delegate = self
        cuntryPickerView.dataSource = self
    }

    
    
    // MARK: - UI Settings
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
    
    
    
    // MARK: - IBAction
    
    @objc func tapLabel() {
        print("tap label")
        cuntryPickerView.isHidden = false
        registerButton.isHidden = true
    }

    @IBAction func contrastClick(_ sender: Any) {
        var configuration = UIButton.Configuration.filled()
        configuration.background.strokeColor = .darkGray
        configuration.background.strokeWidth = 2
        configuration.background.strokeOutset = 5
        configuration.background.cornerRadius = 20
        contrastButton.configuration = configuration
        contrastButton.tintColor = .red
    }
    
    @IBAction func registerButton(_ sender: Any) {
//        let regex = NSRegularExpression(pattern: "/^(?=.*[a-z])(?=.*\\d)[a-zA-Z\\d]{8,16}$/" , options: NSRegularExpression.Options.allowCommentsAndWhitespace)
//        if (passwordTextfield.text?.matches(of: passwordRegularExpression)){
//            print("密碼格式錯誤")
//        }
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


