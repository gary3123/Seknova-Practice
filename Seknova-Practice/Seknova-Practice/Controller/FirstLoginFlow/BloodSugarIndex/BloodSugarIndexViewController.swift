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
        lowSugarPickerView.selectRow(5, inComponent: 0, animated: true)
        highSugarPickerView.dataSource = self
        highSugarPickerView.delegate = self
        highSugarPickerView.selectRow(50, inComponent: 0, animated: true)
        
    }
    
    // MARK: - IBAction
    @IBAction func clickSaveButton(_ sender: Any) {
        navigationController?.pushViewController(TransmitterContentViewController(), animated: true)
    }
    
    @IBAction func clickUnderstandMoreButton(_ sender: Any) {
        // 設定及 popover
        let pop = UnderstandMoreViewController()
        pop.modalPresentationStyle = .popover
        pop.modalPresentationStyle = .popover
        pop.popoverPresentationController?.delegate = self
        pop.popoverPresentationController?.sourceView = understandMoreButton
        pop.popoverPresentationController?.sourceRect = understandMoreButton.bounds
        pop.preferredContentSize = CGSize(width: 300, height: 150)
        present(pop, animated: true)
        
    }
    
    
}

// MARK: - PickerView Extensions
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 將資料儲存到 UserDefault
        if pickerView == lowSugarPickerView {
            UserPreferences.shared.lowBloodSugar = lowSugar[row]
        } else {
            UserPreferences.shared.highBloodSugar = highSugar[row]
        }
    }
    
    
}

// MARK: - Popover Etension
extension BloodSugarIndexViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

// MARK: - Protocol


