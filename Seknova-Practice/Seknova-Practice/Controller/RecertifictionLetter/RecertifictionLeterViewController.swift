//
//  RecertifictionLeterViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/17.
//

import UIKit

class RecertifictionLeterViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var nextStepButton: UIButton!
    
    // MARK: - Variables
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(AlphaBackgroundView(imageName: "Background.jpg", alpha: 0.2), at: 0)
        
    }
    
    
    // MARK: - UI Settings
    
    
    // MARK: - IBAction
    
    @IBAction func clickNextStep(_ sender: Any) {
        print("email:\(UserPreferences.shared.email)")
        print("password:\(UserPreferences.shared.password)")
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    // MARK: - extension
    
    
}

    // MARK: - protocol

