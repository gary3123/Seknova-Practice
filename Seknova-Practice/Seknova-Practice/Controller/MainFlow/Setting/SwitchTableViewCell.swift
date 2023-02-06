//
//  SwitchTableViewCell.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/2.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    
    // MARK: - Variables
    
    static let identifier = "SwitchTableViewCell"
    
    
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


