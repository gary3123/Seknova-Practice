//
//  PairBlueToothViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/30.
//

import UIKit

class PairBlueToothViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleChineseLabel: UILabel!
    @IBOutlet weak var pairButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var blueToothImageView: UIImageView!
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var dotImageView: UIImageView!
    @IBOutlet weak var deviceImageView: UIImageView!
    // MARK: - Variables
    
    // 從 ConnectViewController 傳過來的
    // 用來判斷是否連線成功
    var state: Bool = false
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.sizeToFit()
        view.insertSubview(AlphaBackgroundView(imageName: "Background.jpg", alpha: 0.5), at: 0)
        setNavigationbar(backgroundcolor: .navigationBar!)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.title = "Pair Bluetooth"
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
        if state {
            titleLabel.isHidden = true
            titleChineseLabel.isHidden = true
            pairButton.isHidden = true
            blueToothImageView.isHidden = true
            phoneImageView.isHidden = true
            dotImageView.isHidden = true
            deviceImageView.isHidden = true
            cancelButton.isHidden = true
            stateImageView.image = UIImage(named: "PairSuccess")
            stateImageView.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                let nextVC = ScanningSensorViewController()
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
        } else {
            stateImageView.isHidden = true
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func clickPairButton(_ sender: Any) {
        let connectVC = ConnectViewController()
        navigationController?.pushViewController(connectVC, animated: true)
    }
    
    @IBAction func clickCancelButton(_ sender: Any) {
        UserPreferences.shared.deviceID = ""
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extensions



// MARK: - Protocol


