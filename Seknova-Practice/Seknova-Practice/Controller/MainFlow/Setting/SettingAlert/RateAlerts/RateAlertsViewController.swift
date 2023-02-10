//
//  RateAlertsViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/8.
//

import UIKit

class RateAlertsViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Variables
    var riseAlertStatus = UserPreferences.shared.riseAlert
    var fallAlertStatus = UserPreferences.shared.fallAlert
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: - UI Settings
    func setupUI() {
        setupTableView()
        setupNavigation()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RateAlertsTableViewCell", bundle: nil), forCellReuseIdentifier: RateAlertsTableViewCell.identifier)
        
    }
    
    
    func setupNavigation() {
        self.title = "速率警示"
        let saveBarButtonItem = UIBarButtonItem()
        saveBarButtonItem.title = "儲存"
        navigationItem.rightBarButtonItem = saveBarButtonItem
        saveBarButtonItem.target = self
        saveBarButtonItem.action = #selector(clickSaveBarButtonItem)
    }
    
    
    // MARK: - IBAction
    @objc func clickSwitchButton(_ sender: UISwitch) {
        if sender.tag == 0 {
            riseAlertStatus.toggle()
        } else {
            fallAlertStatus.toggle()
        }
    }
    
    @objc func clickSaveBarButtonItem() {
        UserPreferences.shared.riseAlert = riseAlertStatus
        UserPreferences.shared.fallAlert = fallAlertStatus
        Alert.showAlertWith(title: "已儲存速率警示設定", message: "", vc: self, confirmTitle: "確認") {
            NotificationCenter.default.post(name:.updateAlertsSetting, object: nil)
            self.navigationController?.popViewController(animated: true)
            print("\(UserPreferences.shared.lowSugarAlertsData)")
        }
    }
}

// MARK: - TableView
extension RateAlertsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RateAlertsTableViewCell.identifier, for: indexPath) as! RateAlertsTableViewCell
            cell.optionsLabel.text = "Rise Alert"
            cell.switchButton.isOn = riseAlertStatus
            cell.switchButton.tag = 0
            cell.switchButton.addTarget(self, action: #selector(clickSwitchButton), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: RateAlertsTableViewCell.identifier, for: indexPath) as! RateAlertsTableViewCell
            cell.optionsLabel.text = "Fall Alert"
            cell.switchButton.isOn = fallAlertStatus
            cell.switchButton.tag = 1
            cell.switchButton.addTarget(self, action: #selector(clickSwitchButton), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Alerts when sensor glucose is rising quickly"
        } else {
            return "Alerts when sensor glucose is falling quickly"
        }
    }
    
}


// MARK: - Protocol


