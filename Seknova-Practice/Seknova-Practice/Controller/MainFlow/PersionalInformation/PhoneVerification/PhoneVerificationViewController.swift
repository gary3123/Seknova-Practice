//
//  PhoneVerificationViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/3/6.
//

import UIKit
import RealmSwift

class PhoneVerificationViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var verificationTextField: UITextField!
    
    // MARK: - Variables
    let realm = try! Realm()
    var reloadPersionalInformationDataDelegate: ReloadPersionalInformationData?
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "綁定手機"
        view.insertSubview(AlphaBackgroundView(imageName: "Background.jpg", alpha: 0.2), at: 0)
        setupUI()
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        setupPhoneView()
        setupVerificationTextField()
    }
    
    func setupPhoneView() {
        phoneView.layer.shadowRadius = 5
        phoneView.layer.shadowOpacity = 0.2
        phoneView.layer.shadowOffset = CGSize(width: 0, height: 2)
        phoneTextField.placeholder = "請輸入您的電話號碼"
    }
    
    func setupVerificationTextField() {
        verificationTextField.layer.shadowRadius = 5
        verificationTextField.layer.shadowOpacity = 0.2
        verificationTextField.layer.shadowOffset = CGSize(width: 0, height: 2)
        verificationTextField.placeholder = "請輸入您的驗證碼"
    }
   
   
    // MARK: - IBAction
    @IBAction func clickInputVerification() {
        let userinformationTable = realm.objects(UserInformation.self).filter("userId = '\(UserPreferences.shared.email)'")
        try! realm.write {
            if phoneTextField.text?.first == "0" {
                userinformationTable[0].phone = "\(phoneTextField.text!)"
            } else {
                userinformationTable[0].phone = "0\(phoneTextField.text!)"
            }
            userinformationTable[0].phone_Verified = true
            realm.add(userinformationTable)
        }
        reloadPersionalInformationDataDelegate?.reloadPersionalInformationData()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickBackButton() {
        navigationController?.popViewController(animated: true)
    }
   
}

// MARK: - Extension



// MARK: - Protocol
protocol ReloadPersionalInformationData {
    func reloadPersionalInformationData()
}
