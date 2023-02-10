//
//  LifeStyleLabelTableViewCell.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/10.
//

import UIKit

class LifeStyleLabelTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var replyLabel: UILabel!
    
    
    // MARK: - Variables
    
    static let identifier = "lifeStyleLabelTableViewCell"
    
    
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
