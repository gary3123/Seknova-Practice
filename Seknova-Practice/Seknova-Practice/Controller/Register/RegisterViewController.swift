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
    // MARK: - Variables

    
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextfield()
        // 開啟 Label 交互功能
        cuntryLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapLabel))
        cuntryLabel.addGestureRecognizer(tap)
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
        
    }

}


