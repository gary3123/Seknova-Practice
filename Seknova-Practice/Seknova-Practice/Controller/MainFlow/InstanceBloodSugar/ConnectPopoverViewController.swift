//
//  ConnectPopoverViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2022/12/25.
//

import UIKit

class ConnectPopoverViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var contentLabel: UILabel!
    var connectStatus: ConnectStatus = .bothDisconnect
    
    // MARK: - Variables
    
    enum ConnectStatus {
        case bothDisconnect
        case noSensor
        case noTransmitter
        case bothConnect
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        contentLabel.sizeToFit()
        if UserPreferences.shared.deviceID == "" {
            if UserPreferences.shared.sensorID != "" {
                connectStatus = .noTransmitter
            }
        } else {
            if UserPreferences.shared.sensorID != "" {
                connectStatus = .bothConnect
                contentLabel.textAlignment = .center
            }
        }
        print(contentLabel.text)
        setContentLabel()
        
    }
    // MARK: - setContentLabel
    func setContentLabel() {
        switch connectStatus {
        case .bothDisconnect:
            contentLabel.text = "發射器尚未啟用，請使用者先進行啟用後才可以進一步顯示資料"
        case .noSensor :
            contentLabel.text = "發射器尚未啟用，請使用者先進行啟用後才可以進一步顯示資料"
        case .noTransmitter:
            contentLabel.text = ""
        case .bothConnect :
            contentLabel.text = "感測器已啟用"
            
        }
    }
    
    

    // MARK: - IBAction
   
    
    
    
    
}



// MARK: - Protocol
