//
//  InstanceBloodSugarViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/2.
//

import UIKit

class InstanceBloodSugarViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(AlphaBackgroundView(imageName: "Background5.jpg", alpha: 0.5), at: 0)
        print("這是即時血糖頁面")
    }

}
