//
//  BloodSugarConfirmViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2022/12/26.
//

import UIKit

class BloodSugarConfirmViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK: - Variables
    
    var indexValue = ""
    var dateFormatter = DateFormatter()
    var date = Date()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(AlphaBackgroundView(imageName: "Background5.jpg", alpha: 0.2), at: 0)
        indexLabel.text = indexValue
        updateTime()
    }
    
    
    // MARK: - UI Settings
    
   
    
    // MARK: - updateTime
    
    @objc func updateTime() {
        dateFormatter.amSymbol = "上午"
        dateFormatter.pmSymbol = "下午"
        dateFormatter.dateFormat = "h:m a"
        dateFormatter.locale = Locale(identifier: "zh")
        timeLabel.text = dateFormatter.string(from: date)
    }
    
   
    
    // MARK: - IBAction
    @IBAction func clickConfirmButton(_ sender: Any) {
        NotificationCenter.default.post(name: .goInstanceBloodSugarVC, object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extensions

// MARK: - Protocol





