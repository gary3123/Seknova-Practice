//
//  TabBarController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/2.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let historyVC = HistoryViewController()
        let bloodSugarCorrection = BloodSugarCorrectionViewController()
        let instanceBloodVC = InstanceBloodSugarViewController()
        let lifeStyleVC = LifeStyleViewController()
        let persionalInformation = PersionalInformationViewController()
        
        historyVC.title = "歷史紀錄"
        bloodSugarCorrection.title = "血糖校正"
        instanceBloodVC.title = "即時血糖"
        lifeStyleVC.title = "生活作息"
        persionalInformation.title = "個人資訊"
        self.tabBar.backgroundColor = .secondarySystemBackground
        self.setViewControllers([historyVC,
                                bloodSugarCorrection,
                                instanceBloodVC,
                                lifeStyleVC,
                                persionalInformation],
                                animated: true)
        guard let items = self.tabBar.items else { return }
        let images = ["history","blood-1","trend","calendar-1","user"]
        
        for i in 0...4 {
            items[i].image = UIImage(named: images[i])
        }
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
