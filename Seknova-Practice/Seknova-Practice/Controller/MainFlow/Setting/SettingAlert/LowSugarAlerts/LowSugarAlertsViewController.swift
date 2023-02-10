//
//  LowSugarAlertsViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/7.
//

import UIKit

class LowSugarAlertsViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!

    
    // MARK: - Variables
    var AlertsStatus = UserPreferences.shared.lowSugarAlertSwitch
    var pickerViewDataArray: [String] = []
    var lowLimitData = UserPreferences.shared.lowSugarAlertsData
    var isFirstToLowSugarAlertsVC = true
  
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: - UI Settings
    func setupUI() {
        setupTableView()
        setupPickerView()
        setupNavigation()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LowSugarAlertsSwitchTableViewCell", bundle: nil), forCellReuseIdentifier: LowSugarAlertsSwitchTableViewCell.identifier)
        tableView.register(UINib(nibName: "LowSugarAlertsLabelTableViewCell", bundle: nil), forCellReuseIdentifier: LowSugarAlertsLabelTableViewCell.identifier)
        tableView.register(UINib(nibName: "LowSugarAlertsPickerViewTableViewCell", bundle: nil), forCellReuseIdentifier: LowSugarAlertsPickerViewTableViewCell.identifier)
    }
    
    func setupPickerView() {
        for i in stride(from: 70, through: 90, by: 5) {
            pickerViewDataArray.append("\(i)")
        }
        pickerViewDataArray.insert("-", at: 0)
    }
    
    func setupNavigation() {
        self.title = "低血糖警示"
        let saveBarButtonItem = UIBarButtonItem()
        saveBarButtonItem.title = "儲存"
        navigationItem.rightBarButtonItem = saveBarButtonItem
        saveBarButtonItem.target = self
        saveBarButtonItem.action = #selector(clickSaveBarButtonItem)
    }
    
    
    // MARK: - IBAction
    @objc func clickSwitchButton() {
        AlertsStatus.toggle()
    }
 
    @objc func clickSaveBarButtonItem() {
        if AlertsStatus == true && lowLimitData == 0 {
            Alert.showAlertWith(title: "請設定低血糖警示數值", message: "", vc: self, confirmTitle: "確認")
        } else {
            if AlertsStatus == false {
                UserPreferences.shared.lowSugarAlertSwitch = AlertsStatus
                UserPreferences.shared.lowSugarAlertsData = 0
            } else {
                UserPreferences.shared.lowSugarAlertSwitch = AlertsStatus
                UserPreferences.shared.lowSugarAlertsData = lowLimitData
            }
            Alert.showAlertWith(title: "已儲存低血糖警示設定", message: "", vc: self, confirmTitle: "確認") {
                NotificationCenter.default.post(name:.updateAlertsSetting, object: nil)
                self.navigationController?.popViewController(animated: true)
                print("\(UserPreferences.shared.lowSugarAlertsData)")
            }
        }
        
    }
    
    
}

// MARK: - TableView
extension LowSugarAlertsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableViewSection = ["","低血糖警示"]
        return tableViewSection[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LowSugarAlertsSwitchTableViewCell.identifier, for: indexPath) as! LowSugarAlertsSwitchTableViewCell
            cell.optionsLabel.text = "低血糖警示"
            cell.switchButton.isOn = AlertsStatus
            cell.switchButton.addTarget(self, action: #selector(clickSwitchButton), for: .touchUpInside)
            return cell
        } else {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: LowSugarAlertsLabelTableViewCell.identifier, for: indexPath) as! LowSugarAlertsLabelTableViewCell
                cell.optionsLabel.text = "Low Limit"
                if lowLimitData == 0 {
                    cell.replyLabel.text = "-"
                } else {
                    cell.replyLabel.text = "\(lowLimitData) mg/dL"
                }
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: LowSugarAlertsPickerViewTableViewCell.identifier, for: indexPath) as! LowSugarAlertsPickerViewTableViewCell
                cell.pickerView.delegate = self
                cell.pickerView.dataSource = self
                if isFirstToLowSugarAlertsVC == true {
                    
                    if UserPreferences.shared.highSugarAlertsData == 0 {
                        cell.pickerView.selectRow(0, inComponent: 0, animated: true)
                    } else {
                        cell.pickerView.selectRow((UserPreferences.shared.lowSugarAlertsData / 5) - 13 , inComponent: 0, animated: true)
                    }
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                return 180
            } else {
                return 44
            }
        } else {
            return 44
        }
    }
}

extension LowSugarAlertsViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewDataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewDataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerViewDataArray[row] == "-" {
            lowLimitData = 0
        } else {
            lowLimitData =  Int(pickerViewDataArray[row])!
        }
        isFirstToLowSugarAlertsVC = false
        tableView.reloadData()
    }
    
}

// MARK: - Protocol


