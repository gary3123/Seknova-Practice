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
    
    // MARK: - Variables
    let lowSugar = Array(65...75)
    let highSugar = Array(150...250)
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(AlphaBackgroundView(imageName: "Background.jpg"), at: 0)
        setupUI()
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        setupPickerView()
    }
    
    func setupPickerView() {
        lowSugarPickerView.dataSource = self
        lowSugarPickerView.delegate = self
        highSugarPickerView.dataSource = self
        highSugarPickerView.delegate = self
        
    }
    
    // MARK: - IBAction
    
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


