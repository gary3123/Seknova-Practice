//
//  ScanningSensorViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/2.
//

import UIKit

class ScanningSensorViewController: BaseViewController{
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var textInputButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - Variables
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(AlphaBackgroundView(imageName: "Background5.jpg", alpha: 0.5), at: 0)
        navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Scanning Sensor"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        
    }
    
    // MARK: - IBAction
    
    @IBAction func clickTextInput(_ sender: Any) {
        Alert.showAlertWith(title: "文字輸入",
                            message: "請輸入裝置 ID",
                            vc: self,
                            confirmtitle: "確認",
                            canceltitle: "取消") { textfield in
            textfield.delegate = self
            textfield.keyboardType = .asciiCapable
            textfield.placeholder = "輸入裝置 ID 後六碼"
            textfield.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        } confirm: { textfield in
            guard let text = textfield.text else { return }
            if text.validate(type: .deviceID) {
               
                Alert.showAlertWith(title: "確認裝置碼", message: "確認裝置碼為 \(text) ?", vc: self, confirmTitle: "確認", cancelTitle: "返回") {
                    UserPreferences.shared.sensorID = textfield.text!
                    self.navigationController?.pushViewController(TabBarController(), animated: true)
                }cancel: {
                    
                    textfield.text = ""
                }
            } else {
                Alert.showAlertWith(title: "輸入裝置 ID 格式錯誤",
                                    message: "輸入格式錯誤，請重新輸入",
                                    vc: self,
                                    confirmTitle: "確認")
            }
        }
    }

    @IBAction func clickSkipButton(_ sender: Any) {
        
        navigationController?.pushViewController(TabBarController(), animated: true)
        
    }
    
}

// MARK: - Extensions
extension ScanningSensorViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let countOfWords = textField.text!.count - range.length + string.count
        
        if countOfWords > 6 {
            return false
        }
        return true
    }
    
}


// MARK: - Protocol


