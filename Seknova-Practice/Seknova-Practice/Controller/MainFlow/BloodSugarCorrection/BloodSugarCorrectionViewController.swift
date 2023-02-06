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

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(AlphaBackgroundView(imageName: "Background5.jpg", alpha: 0.2), at: 0)
        
        addIndexButton.tag = 0
        minusIndexButton.tag = 1
        
       
    }
    
    
    // MARK: - UI Settings
    
   
    
    // MARK: - randomProduce
    
   
    
    // MARK: - IBAction
    
    @objc func longPressAction() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.count += 1
            print(self.count)
        }
       
    }
    
    
    @IBAction func clickAddIndexButton() {
        let longPressd = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        addIndexButton.addGestureRecognizer(longPressd)
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

