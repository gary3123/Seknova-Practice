//
//  ReloadTableViewCell.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/2.
//

import UIKit

class ReloadTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var optionsLabel: UILabel!
    
    
    // MARK: - Variables
    
    static let identifier = "reloadTableViewCell"
    
    
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


