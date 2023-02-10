//
//  LifeStyleTextFieldTableViewCell.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/10.
//

import UIKit

class LifeStyleTextFieldTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    // MARK: - Variables
    
    static let identifier = "lifeStyleTextFieldTableViewCell"
    
    
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
