//
//  PairBlueToothViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/30.
//

import UIKit

class PairBlueToothViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var titleTextField: UILabel!
    
    
    // MARK: - Variables
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.sizeToFit()
        view.insertSubview(AlphaBackgroundView(imageName: "Background.jpg", alpha: 0.5), at: 0)
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


