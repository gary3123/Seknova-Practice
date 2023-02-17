//
//  OtherEventTableViewCell.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/16.
//

import UIKit

class OtherEventTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var editAndDeleteButton: UIButton!
    @IBOutlet weak var eventSubtitleLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteReplyLabel: UILabel!
    @IBOutlet weak var hiddenView: UIView!
    
    
    
    // MARK: - Variables
    
    static let identifier = "otherEventTableViewCell"
    
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noteLabel.text = "註記："
    }
    
    
    // MARK: - UI Settings
    
    func expand() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4) {
                self.hiddenView.transform = CGAffineTransform(translationX: 0, y:  self.hiddenView.frame.height)
            }
        }
    }
    
    func close() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4) {
                self.hiddenView.transform = CGAffineTransform(translationX: 0, y:  0)
            }
        }
    }
    
    // MARK: - IBAction
    
}

// MARK: - Extensions



// MARK: - Protocol


