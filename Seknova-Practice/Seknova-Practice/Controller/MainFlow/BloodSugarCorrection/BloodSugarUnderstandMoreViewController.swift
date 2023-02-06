//
//  BloodSugarUnderstandMoreViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2022/12/26.
//

import UIKit

class BloodSugarUnderstandMoreViewController: UIViewController {
    
    @IBOutlet weak var contentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        contentLabel.text = "系統暖機完後須進行第一次血糖校正，請透過任證的血糖機量測血糖值，並將量測的血糖值輸入在血糖校正的欄位。"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
