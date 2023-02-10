//
//  SettingAlertViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/3.
//

import UIKit

class SettingAlertViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!

    
    // MARK: - Variables
  
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "警示設定"
        NotificationCenter.default.addObserver(self, selector: #selector(tableViewReload), name: .updateAlertsSetting, object: nil)
        setupUI()
        
    }
    
    // MARK: - UI Settings
    func setupUI() {
        setTableView()
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SettingAlertTableViewCell", bundle: nil), forCellReuseIdentifier: SettingAlertTableViewCell.identifier)
    }
    
    @objc func tableViewReload() {
        tableView.reloadData()
    }
    
    
    
    // MARK: - IBAction
    
 
    
    
}

// MARK: - TableView
extension SettingAlertViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: SettingAlertTableViewCell.identifier, for: indexPath) as! SettingAlertTableViewCell
                cell.optionsLabel.text = AppDefine.SettingAlert.allCases[indexPath.row].title
                if UserPreferences.shared.highSugarAlertsData == 0 || UserPreferences.shared.highSugarAlertSwitch == false {
                    cell.replyLabel.text = "none"
                } else {
                    cell.replyLabel.text = "\(UserPreferences.shared.highSugarAlertsData) md/gL"
                }
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: SettingAlertTableViewCell.identifier, for: indexPath) as! SettingAlertTableViewCell
                cell.optionsLabel.text = AppDefine.SettingAlert.allCases[indexPath.row].title
                if UserPreferences.shared.lowSugarAlertsData == 0 || UserPreferences.shared.lowSugarAlertSwitch == false {
                    cell.replyLabel.text = "none"
                } else {
                    cell.replyLabel.text = "\(UserPreferences.shared.lowSugarAlertsData) md/gL"
                }
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingAlertTableViewCell.identifier, for: indexPath) as! SettingAlertTableViewCell
            cell.optionsLabel.text = AppDefine.SettingAlert.allCases[indexPath.row + 2].title
            if UserPreferences.shared.fallAlert == false && UserPreferences.shared.riseAlert == false {
                cell.replyLabel.text = "none"
            } else if UserPreferences.shared.riseAlert == true && UserPreferences.shared.fallAlert == true {
                cell.replyLabel.text = "Rise Alert , Fall Alert"
            } else if UserPreferences.shared.riseAlert == true {
                cell.replyLabel.text = "Rise Alert"
            } else {
                cell.replyLabel.text = "Fall Alert"
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingAlertTableViewCell.identifier, for: indexPath) as! SettingAlertTableViewCell
            cell.optionsLabel.text = AppDefine.SettingAlert.allCases[indexPath.row + 3].title
            cell.replyLabel.text = UserPreferences.shared.alertAudio
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let nextVC = HighSugarAlertsViewController()
                navigationItem.backButtonTitle = "返回"
                navigationController?.pushViewController(nextVC, animated: true)
            default:
                let nextVC = LowSugarAlertsViewController()
                nextVC.navigationItem.backButtonTitle = "返回"
                navigationController?.pushViewController(nextVC, animated: true)
            }
        } else if indexPath.section == 1 {
            let nextVC = RateAlertsViewController()
            nextVC.navigationItem.backButtonTitle = "返回"
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            let nextVC = AudioViewController()
            nextVC.navigationItem.backButtonTitle = "返回"
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Note: Urgent low alert at 55 mg/dL is always on."
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        } else if section == 1 {
            return 10
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 60
        } else if section == 1 {
            return 10
        } else {
            return 1
        }
    }
    
}

// MARK: - Protocol


