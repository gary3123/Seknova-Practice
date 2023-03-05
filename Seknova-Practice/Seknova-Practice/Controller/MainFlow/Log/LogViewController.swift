//
//  LogViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/3/6.
//

import UIKit

class LogViewController: UIViewController {
    // MARK: - IBOutlet
    
    // MARK: - Variables
  
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Logs"
        setupUI()
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        setupAllButtonItem()
    }
    
    func setupAllButtonItem() {
        let allButtonItem = UIButton(type: .custom)
        allButtonItem.setTitle("All", for: .normal)
      
        let allButtonView = UIBarButtonItem(customView: allButtonItem)
        // 設定寬
        let allButtonViewWidth = allButtonView.customView?.widthAnchor.constraint(equalToConstant: 20)
        allButtonViewWidth?.isActive = true
        // 設定高
        let allButtonViewHeight = allButtonView.customView?.heightAnchor.constraint(equalToConstant: 20)
        allButtonViewHeight?.isActive = true
        navigationItem.rightBarButtonItem = allButtonView
    }
   
    // MARK: - IBAction
   
}

// MARK: - Extension



// MARK: - Protocol
