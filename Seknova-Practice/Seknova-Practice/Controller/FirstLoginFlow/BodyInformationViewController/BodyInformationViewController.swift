//
//  BodyInformationViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/24.
//

import UIKit

class BodyInformationViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextStep: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Variables

    var informationAnsArray: [String] = ["", "", "", "", "", "", "", "", "", "", "", ""]
    var datePickerStatus = false
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Persional Information"
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        setNavigationbar(backgroundcolor: .navigationBar!)
        
        informationAnsArray[AppDefine.PersonInformation.email.rawValue] = UserPreferences.shared.email
        
        tableView.isPrefetchingEnabled = false
        tableView.sectionHeaderTopPadding = 0
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        setTableView()
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BodyInformationTableViewCell", bundle: nil),
                           forCellReuseIdentifier: BodyInformationTableViewCell.identifier)
        tableView.register(UINib(nibName: "BodyInformationArrowTableViewCell", bundle: nil),
                           forCellReuseIdentifier: BodyInformationArrowTableViewCell.identifier)
    }
    
    private func setAccessoryImage() -> UIView {
        let accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        let accessoryImageView = UIImageView(frame: CGRect(x: -10, y: 8, width: 25, height: 35))
        accessoryImageView.image = UIImage(named: "ArrowDown2")
        accessoryImageView.contentMode = .scaleAspectFit
        accessoryView.addSubview(accessoryImageView)
        return accessoryView
    }
    
    
    @objc func datepicker() {
        if datePickerStatus == true {
            datePicker.isHidden = false
            nextStep.isHidden = true
        } else {
            datePicker.isHidden = true
            nextStep.isHidden = false
        }
        
    }
    
    // MARK: - IBAction
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension BodyInformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return AppDefine.PersonInformation.allCases.count
        } else {
            return AppDefine.BodyInformation.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch AppDefine.PersonInformation.allCases[indexPath.row] {
            case .firstName:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.placeholder = "點擊進行編輯"
                cell.textField.text = informationAnsArray[indexPath.row]
                cell.textField.delegate = self
                return cell
            case .lastName:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.placeholder = "點擊進行編輯"
                cell.textField.text = informationAnsArray[indexPath.row]
                cell.textField.delegate = self
                return cell
            case .birthday:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationArrowTableViewCell.identifier, for: indexPath) as! BodyInformationArrowTableViewCell
                cell.optionLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.accessoryView = setAccessoryImage()
                return cell
            case .email:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.text = informationAnsArray[indexPath.row]
                return cell
            case .phone:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.placeholder = "點擊進行編輯"
                cell.textField.text = informationAnsArray[indexPath.row]
                cell.textField.keyboardType = .numberPad
                cell.textField.delegate = self
                return cell
            case .address:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.placeholder = "點擊進行編輯"
                cell.textField.text = informationAnsArray[indexPath.row]
                cell.textField.delegate = self
                return cell
            }
        } else {
            switch AppDefine.BodyInformation.allCases[indexPath.row] {
            case .sex:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationArrowTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationArrowTableViewCell
                cell.optionLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.accessoryView = setAccessoryImage()
                return cell
            case .height:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationTableViewCell
                cell.optionsLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row + 6
                cell.textField.placeholder = "點擊進行編輯"
                cell.textField.text = informationAnsArray[indexPath.row + 6]
                cell.textField.keyboardType = .numberPad
                cell.textField.delegate = self
                return cell
            case .weight:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationTableViewCell
                cell.optionsLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row + 6
                cell.textField.placeholder = "點擊進行編輯"
                cell.textField.text = informationAnsArray[indexPath.row + 6]
                cell.textField.keyboardType = .numberPad
                cell.textField.delegate = self
                return cell
            case .race:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationArrowTableViewCell.identifier,
                                                    for: indexPath) as! BodyInformationArrowTableViewCell
                cell.optionLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.accessoryView = setAccessoryImage()
                return cell
            case .drink:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationArrowTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationArrowTableViewCell
                cell.optionLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
               
                cell.accessoryView = setAccessoryImage()
                return cell
            case .smoke:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationArrowTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationArrowTableViewCell
                cell.optionLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.accessoryView = setAccessoryImage()
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            switch AppDefine.BodyInformation.allCases[indexPath.row] {
            case .sex:
                Alert.showActionSheet(array: AppDefine.BodyInformation.allCases[indexPath.row].value,
                                      canceltitle: "取消",
                                      vc: self) { response in
                    
                }
            case .race:
                Alert.showActionSheet(array: AppDefine.BodyInformation.allCases[indexPath.row].value,
                                      canceltitle: "取消",
                                      vc: self) { response in
                    
                }
            case .drink:
                Alert.showActionSheet(array: AppDefine.BodyInformation.allCases[indexPath.row].value,
                                      canceltitle: "取消",
                                      vc: self) { response in
                    
                }
            case .smoke:
                Alert.showActionSheet(array: AppDefine.BodyInformation.allCases[indexPath.row].value,
                                      canceltitle: "取消",
                                      vc: self) { response in
                    
                }
            default:
                return
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let group = ["個人資訊", "身體數值"]
        return group[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}

// MARK: - UITextFieldDelegate

extension BodyInformationViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        informationAnsArray[textField.tag] = text
        
        print(informationAnsArray)
    }
}

// MARK: - UILabelDelegate



// MARK: - Protocol


