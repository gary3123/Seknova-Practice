//
//  BodyInformationViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/24.
//

import UIKit
import RealmSwift

class BodyInformationViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextStep: UIButton!
    @IBOutlet weak var birthdayView: UIView!
    @IBOutlet weak var doneBarbuttonItem: UIBarButtonItem!
    @IBOutlet weak var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var toolBar: UIToolbar!
    
    // MARK: - Variables
    
    var informationAnsArray: [String] = ["", "", "", "", "", "", "", "", "", "", "", ""]
    var datePickerStatus = false
    let fullScreenSize = UIScreen.main.bounds.size
    
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
        setBirthDayPicker()
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
    
    func setBirthDayPicker() {
        birthdayPicker.locale = Locale(identifier: "zh_TW")
        birthdayPicker.maximumDate = Date()
        birthdayView.addSubview(birthdayPicker)
    }
    
    
    func clickDatePicker() {
        if datePickerStatus == true{
            birthdayView.isHidden = false
        } else {
            birthdayView.isHidden = true
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func clickDoneBarButtonItem(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        datePickerStatus = false
        birthdayView.isHidden = true
        informationAnsArray[2] = formatter.string(from: birthdayPicker.date)
        tableView.reloadData()
    }
    
    @IBAction func clickCancelBarButtomItem(_ sender: Any) {
        datePickerStatus = false
        birthdayView.isHidden = true
    }
    
    @IBAction func clickNextStep(_ sender: Any) {
        //判斷資料是否填寫完整，地址及電話號碼則不是必須填的
        var dataCompleted = false
        for i in 0...11 {
            if(informationAnsArray[i] == "") {
                if i == 4 || i == 5 {
                } else {
                    dataCompleted = false
                    break
                }
            } else {
                    dataCompleted = true
            }
        }
        if( dataCompleted == true ) {
            addData() //呼叫新增資料的 func
            let nextVC = TransmitterContentViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        } else {
            Alert.showAlertWith(title: "資料填寫不完整", message: "", vc: self, confirmTitle: "確認")
        }
    }
    
    // MARK: - addData
    
    func addData() {
        var smokeData: Bool
        if (informationAnsArray[11] == "有") {
            smokeData = true
        } else {
            smokeData = false
        }
        let addData = UserInformationTable(userId: informationAnsArray[3],
                                       firstName: informationAnsArray[0],
                                       lastName: informationAnsArray[1],
                                       birthady: informationAnsArray[2],
                                       email: informationAnsArray[3],
                                       phone: informationAnsArray[4],
                                       address: informationAnsArray[5],
                                       gender: informationAnsArray[6],
                                    height: Int(informationAnsArray[7])!,
                                       weight: Int(informationAnsArray[8])!,
                                       race: informationAnsArray[9],
                                       liquor: informationAnsArray[10],
                                       smoke: smokeData,
                                       check: false,
                                       phone_Verified: false)
        LocalDatabase.shared.addUserInformation(userInformation: addData)
    }
    
    
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
                cell.textField.delegate = self
                return cell
            case .lastName:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.placeholder = "點擊進行編輯"
                cell.textField.delegate = self
                return cell
            case .birthday:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationArrowTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationArrowTableViewCell
                cell.ansLabel.text = informationAnsArray[2]
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
                cell.textField.keyboardType = .numberPad
                cell.textField.delegate = self
                return cell
            case .address:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.placeholder = "點擊進行編輯"
                cell.textField.delegate = self
                return cell
            }
        } else {
            switch AppDefine.BodyInformation.allCases[indexPath.row] {
            case .sex:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationArrowTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationArrowTableViewCell
                cell.optionLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.ansLabel.text = informationAnsArray[6]
                cell.accessoryView = setAccessoryImage()
                return cell
            case .height:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationTableViewCell
                cell.optionsLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row + 6
                cell.textField.placeholder = "點擊進行編輯"
                cell.textField.keyboardType = .numberPad
                cell.textField.delegate = self
                return cell
            case .weight:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationTableViewCell
                cell.optionsLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row + 6
                cell.textField.placeholder = "點擊進行編輯"
                cell.textField.keyboardType = .numberPad
                cell.textField.delegate = self
                return cell
            case .race:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationArrowTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationArrowTableViewCell
                cell.optionLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.ansLabel.text = informationAnsArray[9]
                cell.accessoryView = setAccessoryImage()
                return cell
            case .drink:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationArrowTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationArrowTableViewCell
                cell.optionLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.ansLabel.text = informationAnsArray[10]
                cell.accessoryView = setAccessoryImage()
                return cell
            case .smoke:
                let cell = tableView.dequeueReusableCell(withIdentifier: BodyInformationArrowTableViewCell.identifier,
                                                         for: indexPath) as! BodyInformationArrowTableViewCell
                cell.optionLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.ansLabel.text = informationAnsArray[11]
                cell.accessoryView = setAccessoryImage()
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.section == 0 {
            
            if indexPath.row == 2 {
                datePickerStatus.toggle()
                clickDatePicker()
            }
            
        } else if indexPath.section == 1 {
            switch AppDefine.BodyInformation.allCases[indexPath.row] {
            case .sex:
                Alert.showActionSheet(array: AppDefine.BodyInformation.allCases[indexPath.row].value,
                                      canceltitle: "取消",
                                      vc: self) { [unowned self] response in
                    informationAnsArray[6] = AppDefine.BodyInformation.sex.value[response]
                    tableView.reloadData()
                    
                }
            case .race:
                Alert.showActionSheet(array: AppDefine.BodyInformation.allCases[indexPath.row].value,
                                      canceltitle: "取消",
                                      vc: self) { [unowned self] response in
                    self.informationAnsArray[9] = AppDefine.BodyInformation.race.value[response]
                    tableView.reloadData()
                    
                }
            case .drink:
                Alert.showActionSheet(array: AppDefine.BodyInformation.allCases[indexPath.row].value,
                                      canceltitle: "取消",
                                      vc: self) { [unowned self] response in
                    self.informationAnsArray[10] = AppDefine.BodyInformation.drink.value[response]
                    tableView.reloadData()
                }
            case .smoke:
                Alert.showActionSheet(array: AppDefine.BodyInformation.allCases[indexPath.row].value,
                                      canceltitle: "取消",
                                      vc: self) { [unowned self] response in
                    self.informationAnsArray[11] = AppDefine.BodyInformation.smoke.value[response]
                    tableView.reloadData()
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


