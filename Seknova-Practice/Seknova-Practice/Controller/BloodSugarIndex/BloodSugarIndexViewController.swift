//
//  BloodSugarIndexViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/25.
//

import UIKit

class BloodSugarIndexViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var lowSugarPickerView: UIPickerView!
    @IBOutlet weak var highSugarPickerView: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var understandMoreButton: UIButton!
    
    // MARK: - Variables
    let lowSugar = Array(65...75)
    let highSugar = Array(150...250)
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(AlphaBackgroundView(imageName: "SugarIndex.jpg", alpha: 1), at: 0)
        setupUI()
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        setupPickerView()
    }
    
    func setupPickerView() {
        lowSugarPickerView.dataSource = self
        lowSugarPickerView.delegate = self
        lowSugarPickerView.layer.shadowOpacity = 0.5
        highSugarPickerView.dataSource = self
        highSugarPickerView.delegate = self
        
    }
    
    // MARK: - IBAction
    @IBAction func clickSaveButton(_ sender: Any) {
        navigationController?.pushViewController(TransmitterContentViewController(), animated: true)
    }
    
    @IBAction func clickUnderstandMoreButton(_ sender: Any) {
        
        Alert.showAlertWith(title: "設定高低血糖值", message: "系統會於血糖高於高血糖值或是血糖低於低血糖值時透過通知使用者須進一步處理。通知方式為訊息，鈴聲(可關掉)或電子郵件信箱", vc: self, confirmTitle: "確認")
        
    }
    
    
}

// MARK: - Extensions
extension BloodSugarIndexViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == lowSugarPickerView {
            return lowSugar.count
        }else {
            return highSugar.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == lowSugarPickerView {
            return "\(lowSugar[row])"
        } else {
            return "\(highSugar[row])"
        }
    }
    
    
}



// MARK: - Protocol


