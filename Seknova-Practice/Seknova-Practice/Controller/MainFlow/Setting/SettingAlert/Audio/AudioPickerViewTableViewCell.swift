//
//  AudioPickerViewTableViewCell.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/8.
//

import UIKit

class AudioPickerViewTableViewCell: UITableViewCell {

    // MARK: - IBOutLet
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    // MARK: - Variables
    
    static let identifier = "audioPickerViewTableViewCell"
    
    
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


