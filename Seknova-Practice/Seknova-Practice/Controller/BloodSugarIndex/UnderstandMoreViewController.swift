//
//  UnderstandMoreViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/29.
//

import UIKit

class UnderstandMoreViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var contentTextfield: UILabel!
    
    
    // MARK: - Variables
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextfield.sizeToFit()
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
    
}

// MARK: - Extensions



// MARK: - Protocol


