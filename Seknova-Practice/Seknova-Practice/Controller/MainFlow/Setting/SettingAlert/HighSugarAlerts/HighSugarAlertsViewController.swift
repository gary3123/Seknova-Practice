//
//  HighSugarAlertsViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/7.
//

import UIKit

class HighSugarAlertsViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!

    
    // MARK: - Variables
    var AlertsStatus = UserPreferences.shared.highSugarAlertSwitch
    var pickerViewDataArray: [String] = []
    var highLimitData = UserPreferences.shared.highSugarAlertsData
    var isFirstToHighSugarAlertVC = true //每次進來這個頁面都需要給 PickerView 預設值，須用這個狀態來判斷
  
    
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
        tableView.register(UINib(nibName: "HighSugarAlertsSwitchTableViewCell", bundle: nil), forCellReuseIdentifier: HighSugarAlertsSwitchTableViewCell.identifier)
        tableView.register(UINib(nibName: "HighSugarAlertsLabelTableViewCell", bundle: nil), forCellReuseIdentifier: HighSugarAlertsLabelTableViewCell.identifier)
        tableView.register(UINib(nibName: "HighSugarAlertsPickerViewTableViewCell", bundle: nil), forCellReuseIdentifier: HighSugarAlertsPickerViewTableViewCell.identifier)
    }
    
    func setupPickerView() {
        for i in stride(from: 150, through: 250, by: 5) {
            pickerViewDataArray.append("\(i)")
        }
        pickerViewDataArray.insert("-", at: 0)
    }
    
    func setupNavigation() {
        self.title = "高血糖警示"
        let saveBarButtonItem = UIBarButtonItem()
        saveBarButtonItem.title = "儲存"
        navigationItem.rightBarButtonItem = saveBarButtonItem
        saveBarButtonItem.target = self
        saveBarButtonItem.action = #selector(clickSaveBarButtonItem)
    }
    
    
    // MARK: - IBAction
    @objc func clickbackBarButtonItem() {
        Alert.showAlertWith(title: "警告", message: "您的變更尚未儲存，您確定要返回嗎？", vc: self, confirmTitle: "確定", cancelTitle: "取消", confirm: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    @objc func clickSwitchButton() {
        AlertsStatus.toggle()
    }
 
    @objc func clickSaveBarButtonItem() {
        if AlertsStatus == true && highLimitData == 0 {
            Alert.showAlertWith(title: "請設定高血糖警示數值", message: "", vc: self, confirmTitle: "確認")
        } else {
            if AlertsStatus == false {
                UserPreferences.shared.highSugarAlertSwitch = AlertsStatus
                UserPreferences.shared.lowSugarAlertsData = 0
            } else {
                UserPreferences.shared.highSugarAlertSwitch = AlertsStatus
                UserPreferences.shared.highSugarAlertsData = highLimitData
            }
            Alert.showAlertWith(title: "已儲存高血糖警示設定", message: "", vc: self, confirmTitle: "確認") {
                NotificationCenter.default.post(name:.updateAlertsSetting, object: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    
}

// MARK: - TableView
extension HighSugarAlertsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableViewSection = ["","高血糖警示"]
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
            let cell = tableView.dequeueReusableCell(withIdentifier: HighSugarAlertsSwitchTableViewCell.identifier, for: indexPath) as! HighSugarAlertsSwitchTableViewCell
            cell.optionsLabel.text = "高血糖警示"
            cell.switchButton.isOn = AlertsStatus
            cell.switchButton.addTarget(self, action: #selector(clickSwitchButton), for: .touchUpInside)
            return cell
        } else {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: HighSugarAlertsLabelTableViewCell.identifier, for: indexPath) as! HighSugarAlertsLabelTableViewCell
                cell.optionsLabel.text = "High Limit"
                if highLimitData == 0 {
                    cell.replyLabel.text = "-"
                } else {
                    cell.replyLabel.text = "\(highLimitData) mg/dL"
                }
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: HighSugarAlertsPickerViewTableViewCell.identifier, for: indexPath) as! HighSugarAlertsPickerViewTableViewCell
                cell.pickerView.delegate = self
                cell.pickerView.dataSource = self
                // 將 PickerView 的預設值調到已經存起來的資料位置
                if isFirstToHighSugarAlertVC == true {
                    if UserPreferences.shared.highSugarAlertsData == 0 {
                        cell.pickerView.selectRow( 0, inComponent: 0, animated: true)
                    } else {
                        cell.pickerView.selectRow((UserPreferences.shared.highSugarAlertsData / 5) - 29 , inComponent: 0, animated: true)
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

extension HighSugarAlertsViewController: UIPickerViewDelegate,UIPickerViewDataSource{
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
            highLimitData = 0
        } else {
            highLimitData =  Int(pickerViewDataArray[row])!
        }
        isFirstToHighSugarAlertVC = false
        tableView.reloadData()
    }
    
}

// MARK: - Protocol
