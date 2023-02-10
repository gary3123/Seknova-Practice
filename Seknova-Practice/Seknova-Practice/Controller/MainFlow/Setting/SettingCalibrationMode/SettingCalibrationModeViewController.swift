//
//  SettingCalibrationModeViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/5.
//

import UIKit
import RealmSwift

class SettingCalibrationModeViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let calibrationModeArray = ["RawData2BGBias","BGBias","BGLow","BGHigh","MapRate","ThresholdRise","ThresholdFall","RiseRate","FallenRate"]
    var calibrationModeAnsArray: [Int] = []
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: - UI Settings
    func setupUI() {
        setNavigation()
        setTableView()
        setData()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CalibrationModeTableViewCell", bundle: nil), forCellReuseIdentifier: CalibrationModeTableViewCell.identifier)
    }
    
    func setData() {
        let realm = try! Realm()
        let calibrationModeDataTable = realm.objects(CalibrationModeData.self)
        calibrationModeAnsArray.append(calibrationModeDataTable[0].rawData2BGBias)
        calibrationModeAnsArray.append(calibrationModeDataTable[0].BGBias)
        calibrationModeAnsArray.append(calibrationModeDataTable[0].BGLow)
        calibrationModeAnsArray.append(calibrationModeDataTable[0].BGHigh)
        calibrationModeAnsArray.append(calibrationModeDataTable[0].mapRate)
        calibrationModeAnsArray.append(calibrationModeDataTable[0].thresholdRise)
        calibrationModeAnsArray.append(calibrationModeDataTable[0].thresholdFall)
        calibrationModeAnsArray.append(calibrationModeDataTable[0].riseRate)
        calibrationModeAnsArray.append(calibrationModeDataTable[0].fallenRate)
    }
    
    func setNavigation() {
        self.title = "設定校正模式"
        let upDataBarButtonItem = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(clickUpDataBarButtonItem))
        navigationItem.setRightBarButton(upDataBarButtonItem, animated: true)
    }
    
    
    
    // MARK: - IBAction
    @objc func clickUpDataBarButtonItem() {
        let realm = try! Realm()
        let calibrationModeDataTable = realm.objects(CalibrationModeData.self)
        try! realm.write {
            calibrationModeDataTable[0].rawData2BGBias = calibrationModeAnsArray[0]
            calibrationModeDataTable[0].BGBias = calibrationModeAnsArray[1]
            calibrationModeDataTable[0].BGLow = calibrationModeAnsArray[2]
            calibrationModeDataTable[0].BGHigh = calibrationModeAnsArray[3]
            calibrationModeDataTable[0].mapRate = calibrationModeAnsArray[4]
            calibrationModeDataTable[0].thresholdRise = calibrationModeAnsArray[5]
            calibrationModeDataTable[0].thresholdFall = calibrationModeAnsArray[6]
            calibrationModeDataTable[0].riseRate = calibrationModeAnsArray[7]
            calibrationModeDataTable[0].fallenRate = calibrationModeAnsArray[8]
        }
        Alert.showAlertWith(title: "已更新校正模式資料", message: "", vc: self, confirmTitle: "確認")
        print("fileURL:\(realm.configuration.fileURL)")
    }
 
    
    
}

// MARK: - TableView
extension SettingCalibrationModeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalibrationModeTableViewCell.identifier, for: indexPath) as! CalibrationModeTableViewCell
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.textField.text = "\(calibrationModeAnsArray[indexPath.row])"
            cell.textField.tag = indexPath.row
            cell.textField.keyboardType = .numberPad
            cell.textField.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalibrationModeTableViewCell.identifier, for: indexPath) as! CalibrationModeTableViewCell
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.textField.text = "\(calibrationModeAnsArray[indexPath.row])"
            cell.textField.tag = indexPath.row
            cell.textField.keyboardType = .numberPad
            cell.textField.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalibrationModeTableViewCell.identifier, for: indexPath) as! CalibrationModeTableViewCell
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.textField.text = "\(calibrationModeAnsArray[indexPath.row])"
            cell.textField.tag = indexPath.row
            cell.textField.keyboardType = .numberPad
            cell.textField.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalibrationModeTableViewCell.identifier, for: indexPath) as! CalibrationModeTableViewCell
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.textField.text = "\(calibrationModeAnsArray[indexPath.row])"
            cell.textField.tag = indexPath.row
            cell.textField.keyboardType = .numberPad
            cell.textField.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalibrationModeTableViewCell.identifier, for: indexPath) as! CalibrationModeTableViewCell
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.textField.text = "\(calibrationModeAnsArray[indexPath.row])"
            cell.textField.tag = indexPath.row
            cell.textField.keyboardType = .numberPad
            cell.textField.delegate = self
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalibrationModeTableViewCell.identifier, for: indexPath) as! CalibrationModeTableViewCell
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.textField.text = "\(calibrationModeAnsArray[indexPath.row])"
            cell.textField.tag = indexPath.row
            cell.textField.keyboardType = .numberPad
            cell.textField.delegate = self
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalibrationModeTableViewCell.identifier, for: indexPath) as! CalibrationModeTableViewCell
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.textField.text = "\(calibrationModeAnsArray[indexPath.row])"
            cell.textField.tag = indexPath.row
            cell.textField.keyboardType = .numberPad
            cell.textField.delegate = self
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalibrationModeTableViewCell.identifier, for: indexPath) as! CalibrationModeTableViewCell
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.textField.text = "\(calibrationModeAnsArray[indexPath.row])"
            cell.textField.tag = indexPath.row
            cell.textField.keyboardType = .numberPad
            cell.textField.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalibrationModeTableViewCell.identifier, for: indexPath) as! CalibrationModeTableViewCell
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.optionsLabel.text = calibrationModeArray[indexPath.row]
            cell.textField.text = "\(calibrationModeAnsArray[indexPath.row])"
            cell.textField.tag = indexPath.row
            cell.textField.keyboardType = .numberPad
            cell.textField.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "校正模式"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}


// MARK: - TextField

extension SettingCalibrationModeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        calibrationModeAnsArray[textField.tag] = Int(text)!
    }
    
}
// MARK: - Protocol


