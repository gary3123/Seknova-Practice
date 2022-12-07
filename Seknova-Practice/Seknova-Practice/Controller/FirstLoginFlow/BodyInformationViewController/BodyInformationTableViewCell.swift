//
//  BodyInformationTableViewCell.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/5.
//

import UIKit

class BodyInformationTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    // MARK: - Variables
    
    static let identifier = "BodyInformationTableViewCell"
    
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - UI Settings
    
    func setInit() {
        
    }
    
    // MARK: - IBAction
    
}

// MARK: - Extensions



// MARK: - Protocol


