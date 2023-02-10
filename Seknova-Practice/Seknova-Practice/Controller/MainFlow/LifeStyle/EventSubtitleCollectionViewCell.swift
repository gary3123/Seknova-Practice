//
//  EventSubtitleCollectionViewCell.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/9.
//

import UIKit

class EventSubtitleCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var view: UIView!
   
    
    
    // MARK: - Variables
    
    static let identifier = "eventSubtitleCollectionViewCell"
    
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    // MARK: - UI Settings
    
    func setInit() {
        
    }
    
    // MARK: - IBAction
    
}

// MARK: - Extensions



// MARK: - Protocol


