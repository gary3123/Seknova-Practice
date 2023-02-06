//
//  TransmitterTimeAndSensorBatteryPopover.swift
//  Seknova-Practice
//
//  Created by Gary on 2022/12/30.
//

import UIKit
import BatteryView

class TransmitterTimeAndSensorBatteryPopover: UIViewController {
    @IBOutlet weak var batteryIcon: BatteryIcon!
    override func viewDidLoad() {
        super.viewDidLoad()
        let batteryView = BatteryView(frame: CGRect(x: 85, y: 92, width: 30, height: 40))
        batteryView.noLevelText = "?"
        self.view.addSubview(batteryView)
    }
}
