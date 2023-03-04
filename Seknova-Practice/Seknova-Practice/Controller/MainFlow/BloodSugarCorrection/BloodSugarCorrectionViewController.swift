//
//  BloodSugarCorrectionViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/2.
//

import Charts
import UIKit

class BloodSugarCorrectionViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var addIndexButton: UIButton!
    @IBOutlet weak var minusIndexButton: UIButton!
    @IBOutlet weak var indexTextField: UITextField!
    @IBOutlet weak var understandMoreButton: UIButton!
    @IBOutlet weak var save:  UIButton!
    
    
    
    // MARK: - Variables
    var count = 0
    var timer  = Timer()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(AlphaBackgroundView(imageName: "Background5.jpg", alpha: 0.2), at: 0)
        
        addIndexButton.tag = 0
        minusIndexButton.tag = 1
        
        let addLongPressd = UILongPressGestureRecognizer(target: self, action: #selector(longPressToAddAction))
        let minusLongPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressToMinusAction))
        addIndexButton.addGestureRecognizer(addLongPressd)
        minusIndexButton.addGestureRecognizer(minusLongPress)
    }
    
    
    // MARK: - UI Settings
    
   
    
    // MARK: - randomProduce
    
   
    
    // MARK: - IBAction
    
    @objc func longPressToAddAction( recognizer: UILongPressGestureRecognizer ) {
        if recognizer.state == .began {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if self.indexTextField.text == "" {
                    self.indexTextField.text = "1"
                } else if Int(self.indexTextField.text!)! < 400 {
                    self.indexTextField.text = "\(Int(self.indexTextField.text!)! + 1)"
                }
            }
        } else if recognizer.state == .ended {
            timer.invalidate()
        }
    }
    
    @objc func longPressToMinusAction( recognizer: UILongPressGestureRecognizer ) {
        if recognizer.state == .began {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if self.indexTextField.text == "" {
                    self.indexTextField.text = "0"
                } else if Int(self.indexTextField.text!)! > 0 {
                    self.indexTextField.text = "\(Int(self.indexTextField.text!)! - 1)"
                }
            }
        } else if recognizer.state == .ended {
            timer.invalidate()
        }
    }
    
    
    @IBAction func clickAddIndexButton() {
        if indexTextField.text == "" {
            indexTextField.text = "1"
        } else {
            indexTextField.text = "\(Int(indexTextField.text!)! + 1)"
        }
    }
    
    @IBAction func clickMinusIndexButton() {
        if indexTextField.text == "" {
            indexTextField.text = "0"
        } else {
            if indexTextField.text == "0" {
                indexTextField.text = "0"
            } else {
                indexTextField.text = "\(Int(indexTextField.text!)! - 1)"
            }
        }
    }
    
    @IBAction func clickUnderstandMoreButton(_ sender: Any) {
        print(indexTextField.text!)
        let pop = BloodSugarUnderstandMoreViewController()
        pop.modalPresentationStyle = .popover
        pop.modalPresentationStyle = .popover
        pop.popoverPresentationController?.delegate = self
        pop.popoverPresentationController?.sourceView = understandMoreButton
        pop.popoverPresentationController?.sourceRect = understandMoreButton.bounds
        pop.preferredContentSize = CGSize(width: 300, height: 150)
        present(pop, animated: true)
    }
    
    @IBAction func clickSaveButton(_ sender: Any) {
        if Int(indexTextField.text!)! < 55 || Int(indexTextField.text!)! > 400 {
            Alert.showAlertWith(title: "請輸入正確的指數",
                                message: "輸入的指數必須在 55 ~ 400 之間",
                                vc: self,
                                confirmTitle: "確認")
        } else {
            let nextVC = BloodSugarConfirmViewController()
            nextVC.indexValue = indexTextField.text!
            navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
    
}

// MARK: - Extensions
extension BloodSugarCorrectionViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}



// MARK: - Protocol

