//
//  CalibrationModeTableViewCell.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/6.
//

import UIKit

class CalibrationModeTableViewCell: UITableViewCell {

    // MARK: - IBOutlet

    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    // MARK: - Variables
    
    static let identifier = "calibrationModeTableViewCell"
    
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - UI Settings

    
    // MARK: - IBAction
    
}

// MARK: - Extensions



// MARK: - Protocol



