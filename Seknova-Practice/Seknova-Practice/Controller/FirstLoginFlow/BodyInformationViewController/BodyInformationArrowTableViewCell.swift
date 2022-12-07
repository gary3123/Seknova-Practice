//
//  BodyInformationArrowTableViewCell.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/7.
//

import UIKit

class BodyInformationArrowTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var ansLabel: UILabel!
    
    
    // MARK: - Variables
    
    static let identifier = "BodyInformationArrowTableViewCell"
    
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


