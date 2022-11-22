//
//  ForgotPassword.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/21.
//

import UIKit

class ForgotPassword: BaseViewController {
    
    
    // MARK: - IBOutlet
    
    
    // MARK: - Variables


    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationbar(backgroundcolor:  .navigationBar)
        view.insertSubview(AlphaBackgroundView(imageName: "Background.jpg"), at: 0)
        self.title = "Forgot Password"
        
        
        
    }

    // MARK: - UI Settings
    
    
    // MARK: - IBAction


}

// MARK : - Extension
