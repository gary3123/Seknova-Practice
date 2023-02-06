//
//  PersionalInformationViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/2.
//

import UIKit
import RealmSwift

class PersionalInformationViewController: UIViewController {
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
    let accountoptionLabel: [String] = ["發射器裝置", "感測器裝置", "修改密碼"]
    var datePickerStatus = false
    let fullScreenSize = UIScreen.main.bounds.size
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        informationAnsArray[AppDefine.PersonInformation.email.rawValue] = UserPreferences.shared.email
        
        tableView.isPrefetchingEnabled = false
        tableView.sectionHeaderTopPadding = 0
        NotificationCenter.default.addObserver(self, selector: #selector(upadtePersionalInformationToRealm), name: .updatePersionalInformation, object: nil)
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
        setDefaultArray()
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PersionalInformationTableViewCell", bundle: nil),
                           forCellReuseIdentifier: PersionalInformationTableViewCell.identifier)
        tableView.register(UINib(nibName: "AccountSectionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: AccountSectionTableViewCell.identifier)
        tableView.register(UINib(nibName: "LogOutTableViewCell", bundle: nil),
                           forCellReuseIdentifier: LogOutTableViewCell.identifier)
    }
    
    
    func setBirthDayPicker() {
        birthdayPicker.locale = Locale(identifier: "zh_TW")
        birthdayPicker.maximumDate = Date()
        birthdayView.addSubview(birthdayPicker)
    }
    
    func setDefaultArray() {
        let realm = try! Realm()
        let userinformationTable = realm.objects(UserInformation.self).filter("userId = '\(UserPreferences.shared.email)'")
        informationAnsArray[0] = userinformationTable[0].firstName
        informationAnsArray[1] = userinformationTable[0].lastName
        informationAnsArray[2] = userinformationTable[0].birthday
        informationAnsArray[3] = userinformationTable[0].email
        informationAnsArray[4] = userinformationTable[0].phone
        informationAnsArray[5] = userinformationTable[0].address
        informationAnsArray[6] = userinformationTable[0].gender
        informationAnsArray[7] = "\(userinformationTable[0].height)"
        informationAnsArray[8] = "\(userinformationTable[0].weight)"
        informationAnsArray[9] = userinformationTable[0].race
        informationAnsArray[10] = userinformationTable[0].liquor
        if userinformationTable[0].smoke == true {
            informationAnsArray[11] = "是"
        } else {
            informationAnsArray[11] = "否"
        }
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
    @objc func upadtePersionalInformationToRealm() {
        let realm = try! Realm()
        let userinformationTable = realm.objects(UserInformation.self).filter("userId = '\(UserPreferences.shared.email)'")
        try! realm.write {
            userinformationTable[0].firstName = informationAnsArray[0]
            userinformationTable[0].lastName = informationAnsArray[1]
            userinformationTable[0].birthday = informationAnsArray[2]
            userinformationTable[0].email = informationAnsArray[3]
            userinformationTable[0].phone = informationAnsArray[4]
            userinformationTable[0].address = informationAnsArray[5]
            userinformationTable[0].gender = informationAnsArray[6]
            userinformationTable[0].height = Int(informationAnsArray[7]) ?? userinformationTable[0].height
            userinformationTable[0].weight = Int(informationAnsArray[8]) ?? userinformationTable[0].weight
            userinformationTable[0].race = informationAnsArray[9]
            userinformationTable[0].liquor = informationAnsArray[10]
            if (informationAnsArray[11] == "有") {
                userinformationTable[0].smoke = true
            } else {
                userinformationTable[0].smoke = false
            }
            realm.add(userinformationTable)
        }
        Alert.showAlertWith(title: "已更新使用者資料", message: "", vc: self, confirmTitle: "確認")
        print("fileURL:\(realm.configuration.fileURL)")
    }

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

extension PersionalInformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return AppDefine.PersonInformation.allCases.count
        } else if section == 1 {
            return AppDefine.BodyInformation.allCases.count
        } else if section == 2 {
            return accountoptionLabel.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch AppDefine.PersonInformation.allCases[indexPath.row] {
            case .firstName:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersionalInformationTableViewCell.identifier,
                                                         for: indexPath) as! PersionalInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.text = informationAnsArray[0]
                cell.textField.delegate = self
                return cell
            case .lastName:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersionalInformationTableViewCell.identifier,
                                                         for: indexPath) as! PersionalInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.text = informationAnsArray[1]
                cell.textField.delegate = self
                return cell
            case .birthday:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersionalInformationTableViewCell.identifier,
                                                         for: indexPath) as! PersionalInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.text = informationAnsArray[2]
                cell.textField.isEnabled = false
                return cell
            case .email:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersionalInformationTableViewCell.identifier,
                                                         for: indexPath) as! PersionalInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.text = informationAnsArray[3]
                return cell
            case .phone:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersionalInformationTableViewCell.identifier,
                                                         for: indexPath) as! PersionalInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.placeholder = "點擊進行編輯"
                cell.textField.keyboardType = .numberPad
                cell.textField.text = informationAnsArray[4]
                cell.textField.delegate = self
                return cell
            case .address:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersionalInformationTableViewCell.identifier,
                                                         for: indexPath) as! PersionalInformationTableViewCell
                cell.optionsLabel.text = AppDefine.PersonInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row
                cell.textField.placeholder = "點擊進行編輯"
                cell.textField.text = informationAnsArray[5]
                cell.textField.delegate = self
                return cell
            }
        } else if indexPath.section == 1 {
            switch AppDefine.BodyInformation.allCases[indexPath.row] {
            case .sex:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersionalInformationTableViewCell.identifier,
                                                         for: indexPath) as! PersionalInformationTableViewCell
                cell.optionsLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.textField.isEnabled = false
                cell.textField.text = informationAnsArray[6]
                return cell
            case .height:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersionalInformationTableViewCell.identifier,
                                                         for: indexPath) as! PersionalInformationTableViewCell
                cell.optionsLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row + 6
                cell.textField.keyboardType = .numberPad
                cell.textField.text = informationAnsArray[7]
                cell.textField.delegate = self
                return cell
            case .weight:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersionalInformationTableViewCell.identifier,
                                                         for: indexPath) as! PersionalInformationTableViewCell
                cell.optionsLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.textField.tag = indexPath.row + 6
                cell.textField.keyboardType = .numberPad
                cell.textField.text = informationAnsArray[8]
                cell.textField.delegate = self
                return cell
            case .race:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersionalInformationTableViewCell.identifier,
                                                         for: indexPath) as! PersionalInformationTableViewCell
                cell.optionsLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.textField.isEnabled = false
                cell.textField.text = informationAnsArray[9]
                return cell
            case .drink:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersionalInformationTableViewCell.identifier,
                                                         for: indexPath) as! PersionalInformationTableViewCell
                cell.optionsLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.textField.isEnabled = false
                cell.textField.text = informationAnsArray[10]
                return cell
            case .smoke:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersionalInformationTableViewCell.identifier,
                                                         for: indexPath) as! PersionalInformationTableViewCell
                cell.optionsLabel.text = AppDefine.BodyInformation.allCases[indexPath.row].title
                cell.textField.isEnabled = false
                cell.textField.text = informationAnsArray[11]
                return cell
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: AccountSectionTableViewCell.identifier,
                                                         for: indexPath) as! AccountSectionTableViewCell
                cell.optionsLabel.text = accountoptionLabel[indexPath.row]
                cell.textField.text = UserPreferences.shared.deviceID
                cell.textField.isEnabled = false
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: AccountSectionTableViewCell.identifier,
                                                         for: indexPath) as! AccountSectionTableViewCell
                cell.optionsLabel.text = accountoptionLabel[indexPath.row]
                cell.textField.text = UserPreferences.shared.sensorID
                cell.textField.isEnabled = false
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AccountSectionTableViewCell.identifier,
                                                         for: indexPath) as! AccountSectionTableViewCell
                cell.optionsLabel.text = accountoptionLabel[indexPath.row]
                cell.textField.text = ""
                cell.textField.isEnabled = false
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LogOutTableViewCell.identifier,
                                                     for: indexPath) as! LogOutTableViewCell
            cell.logOutLabel.text = "登出"
            return cell
            
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
        } else if indexPath.section == 2 {
            if indexPath.row == 2 {
                var nextVC = ResetPasswordViewController()
                navigationController?.pushViewController(nextVC, animated: true)
            }
        } else {
            var nextVC = LoginViewController()
            nextVC.lastPage = .persionalInformationVC
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let group = ["個人資訊", "身體數值" , "帳號" , ""]
        return group[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}

// MARK: - UITextFieldDelegate

extension PersionalInformationViewController: UITextFieldDelegate {
    
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


