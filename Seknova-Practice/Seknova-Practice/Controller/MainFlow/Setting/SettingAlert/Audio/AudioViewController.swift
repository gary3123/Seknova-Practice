//
//  AudioViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/8.
//

import UIKit

class AudioViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Label: UILabel!
    
    
    // MARK: - Variables
    let audioArray = ["-", "sound1", "sound2", "sound3"]
    var isFirstToAudioVC = true
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Label.text = "Overrides ringer setting to always play a tone, even when your ringer is silenced."
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
        tableView.register(UINib(nibName: "AudioSwitchTableViewCell", bundle: nil), forCellReuseIdentifier: AudioSwitchTableViewCell.identifier)
        tableView.register(UINib(nibName: "AudioLabelTableViewCell", bundle: nil), forCellReuseIdentifier: AudioLabelTableViewCell.identifier)
        tableView.register(UINib(nibName: "AudioPickerViewTableViewCell", bundle: nil), forCellReuseIdentifier: AudioPickerViewTableViewCell.identifier)
        
        
    }
    
    
    func setupNavigation() {
        self.title = "鈴聲設置"
        
    }
    
    
    // MARK: - IBAction
    
    @objc func clickOverrideSwitchButton() {
        UserPreferences.shared.alertAudioOverride.toggle()
        NotificationCenter.default.post(name: .updateAlertsSetting, object: nil)
    }
    
}

// MARK: - TableView
extension AudioViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
            let cell = tableView.dequeueReusableCell(withIdentifier: AudioSwitchTableViewCell.identifier, for: indexPath) as! AudioSwitchTableViewCell
            cell.optionsLabel.text = "Override"
            cell.switchButton.isOn = UserPreferences.shared.alertAudioOverride
            cell.switchButton.addTarget(self, action: #selector(clickOverrideSwitchButton), for: .touchUpInside)
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: AudioLabelTableViewCell.identifier, for: indexPath) as! AudioLabelTableViewCell
                cell.optionsLabel.text = "鈴聲設置"
                if UserPreferences.shared.alertAudio == "none" {
                    cell.replyLabel.text = "-"
                } else {
                    cell.replyLabel.text = UserPreferences.shared.alertAudio
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AudioPickerViewTableViewCell.identifier, for: indexPath) as! AudioPickerViewTableViewCell
                cell.pickerView.dataSource = self
                cell.pickerView.delegate = self
                if isFirstToAudioVC == true {
                    switch UserPreferences.shared.alertAudio {
                    case "none":
                        cell.pickerView.selectRow(0, inComponent: 0, animated: true)
                    case "sound1":
                        cell.pickerView.selectRow(1, inComponent: 0, animated: true)
                    case "sound2":
                        cell.pickerView.selectRow(2, inComponent: 0, animated: true)
                    default:
                        cell.pickerView.selectRow(3, inComponent: 0, animated: true)
                    }
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNonzeroMagnitude
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 45
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Note: the Urgent Low Alert will always override your ringer, regardless of this setting."
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else {
            return "OPTION"
        }
    }
    
}

// MARK: - PickerView

extension AudioViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return audioArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return audioArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            UserPreferences.shared.alertAudio = "none"
        } else {
            UserPreferences.shared.alertAudio = audioArray[row]
        }
        tableView.reloadData()
        isFirstToAudioVC = false
        NotificationCenter.default.post(name: .updateAlertsSetting, object: nil)
    }
    
    
    
}

// MARK: - Protocol



