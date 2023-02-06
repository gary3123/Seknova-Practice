//
//  AccountSectionTableViewCell.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/1/29.
//

import UIKit

class AccountSectionTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    // MARK: - Variables
    
    static let identifier = "AccountSectionTableViewCell"
    
    
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

