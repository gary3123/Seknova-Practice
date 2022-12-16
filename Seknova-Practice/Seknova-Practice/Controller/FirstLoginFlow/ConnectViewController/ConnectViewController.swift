//
//  ConnectViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/2.
//

import UIKit

class ConnectViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var connectImageView: UIImageView!
    @IBOutlet weak var connectionLabel: UILabel!
    @IBOutlet weak var connectingLabel: UILabel!
    @IBOutlet weak var correctImageView: UIImageView!
    @IBOutlet weak var correctLabel: UILabel!
    
    // MARK: - Variables
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(AlphaBackgroundView(imageName: "Background.jpg", alpha: 0.5), at: 0)
        navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
        
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
        connectImageViewAnimation()
    }
    
    func connectImageViewAnimation() {
        connectImageView.image = UIImage.animatedImageNamed("connecting_", duration: 1.8)
        connectImageView.animationRepeatCount = 0 // 0 = 無限
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { timer in
            timer.invalidate()
            let vc = PairBlueToothViewController()
            vc.state = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - IBAction
    
}

// MARK: - Extensions



// MARK: - Protocol


