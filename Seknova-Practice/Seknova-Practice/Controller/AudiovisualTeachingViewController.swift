//
//  AudiovisualTeaching.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/24.
//

import UIKit
import WebKit

class AudiovisualTeachingViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var youtubeVedio: WKWebView!
    @IBOutlet weak var nextStep: UIButton!
    
    
    // MARK: - Variables
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationbar(backgroundcolor: .navigationBar)
        view.insertSubview(AlphaBackgroundView(imageName: "Background.jpg", alpha: 0.2), at: 0)

        setupUI()
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        setupVideo()
    }
    
    func setupVideo() {
        
        let urlString = "https://www.youtube.com/embed/Tzmisk385aw?loop=1&playlist=Tzmisk385aw"
        
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        let request = URLRequest(url: url!)
        youtubeVedio.load(request)
        youtubeVedio.allowsBackForwardNavigationGestures = true
        
    }
    
    // MARK: - IBAction
    
    @IBAction func clickNextStep(_ sender: Any) {
        let bloodSugarIndex = BloodSugarIndexViewController()
        navigationController?.pushViewController(bloodSugarIndex, animated: true)
    }
}

// MARK: - Extensions



// MARK: - Protocol


