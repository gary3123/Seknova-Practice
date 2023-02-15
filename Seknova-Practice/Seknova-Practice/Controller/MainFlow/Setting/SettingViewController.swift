//
//  SettingViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/2.
//

import UIKit

class SettingViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!

    
    // MARK: - Variables
    let formatter = DateFormatter()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "設定"
        setupUI()
    }
    
    // MARK: - UI Settings
    func setupUI() {
        setTableView()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: TextTableViewCell.identifier)
        tableView.register(UINib(nibName: "SwitchTableViewCell", bundle: nil), forCellReuseIdentifier: SwitchTableViewCell.identifier)
        tableView.register(UINib(nibName: "RightArrowTableViewCell", bundle: nil), forCellReuseIdentifier: RightArrowTableViewCell.identifier)
        tableView.register(UINib(nibName: "ReloadTableViewCell", bundle: nil), forCellReuseIdentifier: ReloadTableViewCell.identifier)
    }
    
    
    
    // MARK: - IBAction
    @objc func switchValueChange(_ sender: UISwitch) {
        if (sender.tag == 5 && UserPreferences.shared.SettingDevelopStatus == true) || (sender.tag == 1 && UserPreferences.shared.SettingDevelopStatus == false){
            UserPreferences.shared.unitSwitching = sender.isOn
        } else if sender.tag == 6 {
            UserPreferences.shared.showNumericalInformation = sender.isOn
        } else if sender.tag == 7 {
            UserPreferences.shared.showRSSI = sender.isOn
        } else if sender.tag == 8 {
            UserPreferences.shared.uploadCloud = sender.isOn
        } else if (sender.tag == 9 && UserPreferences.shared.SettingDevelopStatus == true) || (sender.tag == 2 && UserPreferences.shared.SettingDevelopStatus == false) {
            UserPreferences.shared.bloodSugarWarning = sender.isOn
        }
        
    }
 
    
    
}

// MARK: - TableView
extension SettingViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserPreferences.shared.SettingDevelopStatus == false {
            return AppDefine.NormalsettingOption.allCases.count
        } else {
            return AppDefine.DevelopsettingOption.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  UserPreferences.shared.SettingDevelopStatus == false {
            switch AppDefine.NormalsettingOption.allCases[indexPath.row] {
            case .alertSetting:
                let cell = tableView.dequeueReusableCell(withIdentifier: RightArrowTableViewCell.identifier, for: indexPath) as! RightArrowTableViewCell
                cell.optionsLabel.text = AppDefine.NormalsettingOption.allCases[indexPath.row].title
                    return cell
            case .unitSwitching:
                let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
                    cell.optionsLabel.text = AppDefine.NormalsettingOption.allCases[indexPath.row].title
                cell.switchButton.tag = indexPath.row
                cell.switchButton.isOn = UserPreferences.shared.unitSwitching
                cell.switchButton.addTarget(self, action: #selector(switchValueChange), for: .valueChanged)
                    return cell
            case .bloodSugarWarning:
                let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
                    cell.optionsLabel.text = AppDefine.NormalsettingOption.allCases[indexPath.row].title
                cell.switchButton.tag = indexPath.row
                cell.switchButton.isOn = UserPreferences.shared.bloodSugarWarning
                cell.switchButton.addTarget(self, action: #selector(switchValueChange), for: .valueChanged)
                    return cell
            case .dataSynchronize:
                let cell = tableView.dequeueReusableCell(withIdentifier: ReloadTableViewCell.identifier, for: indexPath) as! ReloadTableViewCell
                    cell.optionsLabel.text = AppDefine.NormalsettingOption.allCases[indexPath.row].title
                    return cell
            case .warmUpStatus:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
                cell.optionsLabel.text = AppDefine.NormalsettingOption.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.delegate = self
                if UserPreferences.shared.warmUpStatus == false {
                    cell.textField.text = "Off"
                } else {
                    cell.textField.text = "On"
                }
                return cell
            case .eventLog:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
                cell.optionsLabel.text = AppDefine.NormalsettingOption.allCases[indexPath.row].title
                formatter.dateFormat = "MM/dd HH:mm:ss"
                let date = formatter.string(from: Date())
                cell.textField.text = date
                return cell
            case .firmwareVersion:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
                cell.optionsLabel.text = AppDefine.NormalsettingOption.allCases[indexPath.row].title
                cell.textField.text = "1.24.9"
                return cell
            case .appVersion:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
                cell.optionsLabel.text = AppDefine.NormalsettingOption.allCases[indexPath.row].title
                cell.textField.text = "00.00.61"
                return cell
            }
        } else {
            switch AppDefine.DevelopsettingOption.allCases[indexPath.row] {
            case .alertSetting:
                let cell = tableView.dequeueReusableCell(withIdentifier: RightArrowTableViewCell.identifier, for: indexPath) as! RightArrowTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                    return cell
            case .calibrationmode:
                let cell = tableView.dequeueReusableCell(withIdentifier: RightArrowTableViewCell.identifier, for: indexPath) as! RightArrowTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                    return cell
            case .ADCInitialValue:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                cell.textField.text = "\(UserPreferences.shared.ADCInitialValue)"
                cell.textField.tag = indexPath.row
                cell.textField.keyboardType = .numberPad
                cell.textField.delegate = self
                return cell
            case .xAxisTimeInterval:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.keyboardType = .numbersAndPunctuation
                cell.textField.delegate = self
                if UserPreferences.shared.xAxisTimeInterval == 0 {
                    UserPreferences.shared.xAxisTimeInterval = 3600
                    cell.textField.text = "3600.0 per/s"
                } else {
                    cell.textField.text = "\(UserPreferences.shared.xAxisTimeInterval) per/s"
                }
                return cell
            case .yAxisLimit:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                cell.textField.delegate = self
                cell.textField.tag = indexPath.row
                cell.textField.placeholder = "400,0"
                if UserPreferences.shared.yAxisUpperLimit == 0 {
                    UserPreferences.shared.yAxisUpperLimit = 400
                    UserPreferences.shared.yAxisLowerLimit = 0
                    cell.textField.text = "400,0"
                } else {
                    cell.textField.text = "\(UserPreferences.shared.yAxisUpperLimit),\(UserPreferences.shared.yAxisLowerLimit)"
                }
                return cell
            case .showNumericalInformation:
                let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                cell.switchButton.tag = indexPath.row
                cell.switchButton.isOn = UserPreferences.shared.showNumericalInformation
                cell.switchButton.addTarget(self, action: #selector(switchValueChange), for: .valueChanged)
                    return cell
            case .showRSSI:
                let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                cell.switchButton.tag = indexPath.row
                cell.switchButton.isOn = UserPreferences.shared.showRSSI
                cell.switchButton.addTarget(self, action: #selector(switchValueChange), for: .valueChanged)
                    return cell
            case .uploadCloud:
                let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                cell.switchButton.tag = indexPath.row
                cell.switchButton.isOn = UserPreferences.shared.uploadCloud
                cell.switchButton.addTarget(self, action: #selector(switchValueChange), for: .valueChanged)
                    return cell
            case .unitSwitching:
                let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                cell.switchButton.tag = indexPath.row
                cell.switchButton.isOn = UserPreferences.shared.unitSwitching
                cell.switchButton.addTarget(self, action: #selector(switchValueChange), for: .valueChanged)
                    return cell
            case .bloodSugarWarning:
                let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                cell.switchButton.tag = indexPath.row
                cell.switchButton.isOn = UserPreferences.shared.bloodSugarWarning
                cell.switchButton.addTarget(self, action: #selector(switchValueChange), for: .valueChanged)
                    return cell
            case .dataSynchronize:
                let cell = tableView.dequeueReusableCell(withIdentifier: ReloadTableViewCell.identifier, for: indexPath) as! ReloadTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                    return cell
            case .warmUpStatus:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.delegate = self
                if UserPreferences.shared.warmUpStatus == false {
                    cell.textField.text = "Off"
                } else {
                    cell.textField.text = "On"
                }
                return cell
            case .eventLog:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                formatter.dateFormat = "MM/dd HH:mm:ss"
                let date = formatter.string(from: Date())
                cell.textField.text = date
                return cell
            case .firmwareVersion:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                cell.textField.text = "1.24.9"
                return cell
            case .appVersion:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as! TextTableViewCell
                cell.optionsLabel.text = AppDefine.DevelopsettingOption.allCases[indexPath.row].title
                cell.textField.text = "00.00.61"
                return cell
            }
            
           
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let nextVC = SettingAlertViewController()
            print("\(UserPreferences.shared.highSugarAlertsData)、\(UserPreferences.shared.lowSugarAlertsData)")
            navigationController?.pushViewController(nextVC, animated: true)
        } else if indexPath.row == 1 && UserPreferences.shared.SettingDevelopStatus == true {
            let nextVC = SettingCalibrationModeViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
// MARK: - TextField

extension SettingViewController: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 3 {
            textField.text = ""
        } else if (textField.tag == 11 && UserPreferences.shared.SettingDevelopStatus == true) || (textField.tag == 4 && UserPreferences.shared.SettingDevelopStatus == false) {
            Alert.showAlertWith(title: "請輸入對應字串！", message: "如果輸入 0000  會切換暖機狀態\n如果輸入 8888 則開啟開發模式", vc: self, confirmtitle: "確認", canceltitle: "取消") { textField in
                textField.keyboardType = .numberPad
            } confirm: { textField in
                if textField.text == "0000" {
                    UserPreferences.shared.warmUpStatus.toggle()
                    self.tableView.reloadData()
                } else if textField.text == "8888" {
                    UserPreferences.shared.SettingDevelopStatus.toggle()
                    self.tableView.reloadData()
                } else {
                    Alert.showAlertWith(title: "輸入格式錯誤", message: "", vc: self, confirmTitle: "確認")
                }
            }
            textField.endEditing(false)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if textField.tag == 2 && UserPreferences.shared.SettingDevelopStatus == true {
            UserPreferences.shared.ADCInitialValue = Int(text)!
            print("results:\(UserPreferences.shared.ADCInitialValue)")
        } else if textField.tag == 3 && UserPreferences.shared.SettingDevelopStatus == true {
            UserPreferences.shared.xAxisTimeInterval = Double(text)!
            tableView.reloadData()
            print("results:\(UserPreferences.shared.xAxisTimeInterval)")
        } else if textField.tag == 4 && UserPreferences.shared.SettingDevelopStatus == true {
            let splitArry = text.split(separator: ",")
            UserPreferences.shared.yAxisUpperLimit = Int(splitArry[0])!
            UserPreferences.shared.yAxisLowerLimit = Int(splitArry[1])!
            print("results:\(UserPreferences.shared.yAxisUpperLimit)")
            print("results:\(UserPreferences.shared.yAxisLowerLimit)")
        }
    }
}



// MARK: - Protocol


