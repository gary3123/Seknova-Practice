//
//  LogOutTableViewCell.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/1/17.
//

import UIKit

class LogOutTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var logOutLabel: UILabel!
    
    
    // MARK: - Variables
    
    static let identifier = "LogOutTabelViewCell"
    
    
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
