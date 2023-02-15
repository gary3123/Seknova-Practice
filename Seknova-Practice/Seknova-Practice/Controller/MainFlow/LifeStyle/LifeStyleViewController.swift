//
//  LifeStyleViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/2.
//

import UIKit

class LifeStyleViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var eventTitleCollectionView: UICollectionView!
    @IBOutlet weak var eventSubtitleView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventSubtitleCollectionView: UICollectionView!
    @IBOutlet weak var recordTimeView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var recordTimeLabel: UILabel!
    @IBOutlet weak var countDownPickerView: UIPickerView!
    // MARK: - Variables
    let eventTitleImage = ["meal","exercise","sleep","insulin","awaken","bath","other"]
    let eventTitleLabel = ["用餐","運動","睡眠","胰島素","起床","洗澡","其他"]
    let mealSubtitleImage = ["breakfast","dinner","lunch","snacks","drinks"]
    let mealSubtitleLabel = ["早餐","晚餐","午餐","點心","飲料"]
    let exerciseSubtitleImage = ["high_motion","mid_motion","low_motion"]
    let exerciseSubtitleLabel = ["高強度","中強度","低強度"]
    let sleepSubtitleImage = ["sleep","sleepy","nap","relax"]
    let sleeplSubtitleLabel = ["就寢","午睡","小憩","放鬆時刻"]
    let insulinSubtitleImage = ["insulin","insulin","insulin",]
    let insulinSubtitleLabel = ["速效型","長效型","未指定",]
    var isHideEventSubTitle = true
    var selectedEvenTitle = 0
    var selectedEvenSubtitle = 0
    var isEverTapOfEventSubTitle = false
    let date = Date()
    let dateAndTimeFormatter = DateFormatter()
    let durationFormatter = DateFormatter()
    var mealReplyArray = ["","",""]
    var exerciseReplyArray = ["","00:30",""]
    var sleepReplyArray = ["00:30",""]
    var insulinRelyArray = ["",""]
    var getUpReplayArray = [""]
    var bathReplayArray = [""]
    var otherReplayArray = [""]
    var countDownHrArray: [String] = []
    var countDownMinArray: [String] = []
    var countDownData = "00:30"
    var hr = "00"
    var min = "00"
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        setupEventTitleCollectionView()
        setupEventSubTitleCollectionView()
        setupTableView()
        setupRecordTime()
        setupCountDownView()
    }
    
    func setupRecordTime() {
        dateAndTimeFormatter.dateFormat = "yyyy/MM/dd EEEE a h:m"
        dateAndTimeFormatter.locale = Locale(identifier: "zh_TW")
        recordTimeLabel.text = dateAndTimeFormatter.string(from: Date())
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickRecordTime))
        recordTimeView.addGestureRecognizer(tap)
        datePicker.locale = Locale(identifier: "zh_TW")
    }
    
    func setupCountDownView() {
        countDownPickerView.delegate = self
        countDownPickerView.dataSource = self
        for i in stride(from: 0, through: 23, by: 1) {
            countDownHrArray.append("\(i)")
        }
        for i in stride(from: 0, through: 59, by: 1) {
            countDownMinArray.append("\(i)")
        }
        durationFormatter.dateFormat = "HH:mm"
        durationFormatter.locale = Locale(identifier: "zh_TW")
    }
    
    func  setupEventTitleCollectionView() {
        eventTitleCollectionView.tag = 0
        eventTitleCollectionView.delegate = self
        eventTitleCollectionView.dataSource = self
        eventTitleCollectionView.register(UINib(nibName: "EventTitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: EventTitleCollectionViewCell.identifier)
    }
    
    func  setupEventSubTitleCollectionView() {
        eventSubtitleCollectionView.tag = 1
        eventSubtitleCollectionView.delegate = self
        eventSubtitleCollectionView.dataSource = self
        eventTitleCollectionView.register(UINib(nibName: "EventSubtitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: EventSubtitleCollectionViewCell.identifier)
        eventSubtitleCollectionView.layer.cornerRadius = 10
        
        // shadowOpacity: 陰影透明度
        // shadowOffset: 陰影位置（width：向右偏移 height：向下偏移）
        // shadowRadius: 陰影範圍
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        shadowView.layer.shadowRadius = 10
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LifeStyleTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: LifeStyleTextFieldTableViewCell.identifier)
        tableView.register(UINib(nibName: "LifeStyleLabelTableViewCell", bundle: nil), forCellReuseIdentifier: LifeStyleLabelTableViewCell.identifier)
        tableView.register(UINib(nibName: "LifeStyleNoteTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: LifeStyleNoteTextFieldTableViewCell.identifier)
    }
    
    
    
    // MARK: - IBAction
    
    @objc func clickRecordTime() {
        datePicker.datePickerMode = .dateAndTime
        if timeView.isHidden == true {
            timeView.isHidden = false
            datePicker.isHidden = false
            countDownPickerView.isHidden = true
        } else {
            timeView.isHidden = true
        }
    }
    
    @IBAction func clickDoneButtonInTimeView() {
        if datePicker.isHidden == false {
            recordTimeLabel.text = dateAndTimeFormatter.string(from: datePicker.date)
        } else {
            if selectedEvenTitle == 1 {
                exerciseReplyArray[1] = countDownData
            } else {
                sleepReplyArray[0] = countDownData
            }
            tableView.reloadData()
        }
        timeView.isHidden = true
    }
    
    @IBAction func clickCancelButtonInTimeView() {
        if datePicker.datePickerMode == .dateAndTime {
            datePicker.date = dateAndTimeFormatter.date(from: recordTimeLabel.text!)!
        } else {
            if selectedEvenTitle == 1 {
                datePicker.date = dateAndTimeFormatter.date(from: exerciseReplyArray[1])!
            } else {
                datePicker.date = dateAndTimeFormatter.date(from: sleepReplyArray[0])!
            }
        }
        timeView.isHidden = true
    }
}

// MARK: - CollectionView
extension LifeStyleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return 7
        } else {
            if selectedEvenTitle == 0 {
                return mealSubtitleImage.count
            } else if selectedEvenTitle == 1 || selectedEvenTitle == 3 {
                return 3
            } else {
                return 4
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            switch indexPath.row {
            case 0:
                let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventTitleCollectionViewCell.identifier, for: indexPath) as! EventTitleCollectionViewCell
                cell.image.image = UIImage(named: eventTitleImage[indexPath.row])
                cell.Label.text = eventTitleLabel[indexPath.row]
                if selectedEvenTitle == indexPath.row && isHideEventSubTitle == false {
                    cell.view.backgroundColor = .navigationBar
                } else {
                    cell.view.backgroundColor = .eventTitle
                }
                return cell
            case 1:
                let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventTitleCollectionViewCell.identifier, for: indexPath) as! EventTitleCollectionViewCell
                cell.image.image = UIImage(named: eventTitleImage[indexPath.row])
                cell.Label.text = eventTitleLabel[indexPath.row]
                if selectedEvenTitle == indexPath.row {
                    cell.view.backgroundColor = .navigationBar
                } else {
                    cell.view.backgroundColor = .eventTitle
                }
                return cell
            case 2:
                let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventTitleCollectionViewCell.identifier, for: indexPath) as! EventTitleCollectionViewCell
                cell.image.image = UIImage(named: eventTitleImage[indexPath.row])
                cell.Label.text = eventTitleLabel[indexPath.row]
                if selectedEvenTitle == indexPath.row {
                    cell.view.backgroundColor = .navigationBar
                } else {
                    cell.view.backgroundColor = .eventTitle
                }
                return cell
            case 3:
                let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventTitleCollectionViewCell.identifier, for: indexPath) as! EventTitleCollectionViewCell
                cell.image.image = UIImage(named: eventTitleImage[indexPath.row])
                cell.Label.text = eventTitleLabel[indexPath.row]
                if selectedEvenTitle == indexPath.row {
                    cell.view.backgroundColor = .navigationBar
                } else {
                    cell.view.backgroundColor = .eventTitle
                }
                return cell
            case 4:
                let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventTitleCollectionViewCell.identifier, for: indexPath) as! EventTitleCollectionViewCell
                cell.image.image = UIImage(named: eventTitleImage[indexPath.row])
                cell.Label.text = eventTitleLabel[indexPath.row]
                if selectedEvenTitle == indexPath.row {
                    cell.view.backgroundColor = .navigationBar
                } else {
                    cell.view.backgroundColor = .eventTitle
                }
                return cell
            case 5:
                let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventTitleCollectionViewCell.identifier, for: indexPath) as! EventTitleCollectionViewCell
                cell.image.image = UIImage(named: eventTitleImage[indexPath.row])
                cell.Label.text = eventTitleLabel[indexPath.row]
                if selectedEvenTitle == indexPath.row {
                    cell.view.backgroundColor = .navigationBar
                } else {
                    cell.view.backgroundColor = .eventTitle
                }
                return cell
            default:
                let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventTitleCollectionViewCell.identifier, for: indexPath) as! EventTitleCollectionViewCell
                cell.image.image = UIImage(named: eventTitleImage[indexPath.row])
                cell.Label.text = eventTitleLabel[indexPath.row]
                if selectedEvenTitle == indexPath.row {
                    cell.view.backgroundColor = .navigationBar
                } else {
                    cell.view.backgroundColor = .eventTitle
                }
                return cell
            }
        }else {
            if selectedEvenTitle == 0 {
                switch indexPath.row {
                case 0:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: mealSubtitleImage[indexPath.row])
                    cell.Label.text = mealSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row &&
                        isEverTapOfEventSubTitle == true {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                case 1:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: mealSubtitleImage[indexPath.row])
                    cell.Label.text = mealSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                case 2:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: mealSubtitleImage[indexPath.row])
                    cell.Label.text = mealSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                case 3:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: mealSubtitleImage[indexPath.row])
                    cell.Label.text = mealSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                default:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: mealSubtitleImage[indexPath.row])
                    cell.Label.text = mealSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                }
            } else if selectedEvenTitle == 1 {
                switch indexPath.row {
                case 0:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: exerciseSubtitleImage[indexPath.row])
                    cell.Label.text = exerciseSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row &&
                        isEverTapOfEventSubTitle == true {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                case 1:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: exerciseSubtitleImage[indexPath.row])
                    cell.Label.text = exerciseSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                default:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: exerciseSubtitleImage[indexPath.row])
                    cell.Label.text = exerciseSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                }
                
            } else if selectedEvenTitle == 2 {
                switch indexPath.row {
                case 0:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: sleepSubtitleImage[indexPath.row])
                    cell.Label.text = sleeplSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row &&
                        isEverTapOfEventSubTitle == true {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                case 1:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: sleepSubtitleImage[indexPath.row])
                    cell.Label.text = sleeplSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                case 2:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: sleepSubtitleImage[indexPath.row])
                    cell.Label.text = sleeplSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                default:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: sleepSubtitleImage[indexPath.row])
                    cell.Label.text = sleeplSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                }
            } else if selectedEvenTitle == 3{
                switch indexPath.row {
                case 0:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: insulinSubtitleImage[indexPath.row])
                    cell.Label.text = insulinSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row &&
                        isEverTapOfEventSubTitle == true {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                case 1:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: insulinSubtitleImage[indexPath.row])
                    cell.Label.text = insulinSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                default:
                    let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                    cell.image.image = UIImage(named: insulinSubtitleImage[indexPath.row])
                    cell.Label.text = insulinSubtitleLabel[indexPath.row]
                    if selectedEvenSubtitle == indexPath.row {
                        cell.view.backgroundColor = .eventTitle
                    }
                    return cell
                }
            } else {
                let cell = eventTitleCollectionView.dequeueReusableCell(withReuseIdentifier: EventSubtitleCollectionViewCell.identifier, for: indexPath) as! EventSubtitleCollectionViewCell
                cell.Label.text = ""
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 如果進頁面第一次點選了 EventTitleCollectionView
        //就要下拉 SubTitleEventTitleCollectionView 和 tableView
        //點選不需要有 SubTitleEventTitleCollectionView 的，就上拉
        //(EventTitleCollectionView: tag 0 , SubTitleEventTitleCollectionView: tag 1)
        if collectionView.tag == 0 {
            if indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 {
                if isHideEventSubTitle == false {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.2) {
                            self.eventSubtitleView.transform = CGAffineTransform(translationX: 0, y: 0)
                            self.tableView.transform = CGAffineTransform(translationX: 0,
                                                                         y: self.eventSubtitleView.frame.height + self.tableView.frame.height + self.saveButton.frame.height - self.eventSubtitleView.frame.height)
                        }
                    }
                    isHideEventSubTitle = true
                }
                
            } else {
                if isHideEventSubTitle == true {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.2) {
                            self.eventSubtitleView.transform = CGAffineTransform(translationX: 0, y:  self.eventSubtitleView.frame.height)
                            self.tableView.transform = CGAffineTransform(translationX: 0, y: self.eventSubtitleView.frame.height + self.tableView.frame.height + self.saveButton.frame.height)
                            self.saveButton.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height - self.eventTitleCollectionView.frame.height -  self.recordTimeView.frame.height - 10)
                        }
                    }
                    isHideEventSubTitle = false
                }
            }
            
            selectedEvenSubtitle = 0
            // 每次點選就紀錄 EvenTitle 的值
            selectedEvenTitle = indexPath.row
            // 每次點選 EventTitle 的 cell 就要更新
            eventTitleCollectionView.reloadData()
            eventSubtitleCollectionView.reloadData()
            tableView.reloadData()
        } else {
            // 每次點選就紀錄 selectedEvenSubtitle 的值
            selectedEvenSubtitle = indexPath.row
            // 每次點選 EventTitle 的 cell 就要更新
            eventSubtitleCollectionView.reloadData()
            isEverTapOfEventSubTitle = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            if selectedEvenTitle == 0 {
                let width = collectionView.frame.width / 5
                return CGSize(width: width, height: collectionView.frame.height)
            } else if selectedEvenTitle == 1 || selectedEvenTitle == 3 {
                let width = collectionView.frame.width / 3
                return CGSize(width: width, height: collectionView.frame.height)
            } else {
                let width = collectionView.frame.width / 4
                return CGSize(width: width, height: collectionView.frame.height)
            }
        } else {
            return CGSize(width: 70, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

// MARK: -TableView
extension LifeStyleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedEvenTitle {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 2
        case 3:
            return 2
        case 4:
            return 1
        case 5:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedEvenTitle {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleTextFieldTableViewCell.identifier, for: indexPath) as! LifeStyleTextFieldTableViewCell
                cell.optionsLabel.text = "品名"
                cell.textField.placeholder = "添加"
                cell.textField.text = mealReplyArray[0]
                cell.textField.tag = indexPath.row
                cell.textField.delegate = self
                cell.textField.rightViewMode = .never
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleTextFieldTableViewCell.identifier, for: indexPath) as! LifeStyleTextFieldTableViewCell
                cell.optionsLabel.text = "份量"
                cell.textField.text = mealReplyArray[1]
                cell.textField.tag = indexPath.row
                cell.textField.delegate = self
                cell.textField.keyboardType = .numberPad
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleNoteTextFieldTableViewCell.identifier, for: indexPath) as! LifeStyleNoteTextFieldTableViewCell
                cell.optionsLabel.text = "註記"
                cell.replyTextField.text = mealReplyArray[2]
                cell.replyTextField.tag = indexPath.row
                cell.replyTextField.delegate = self
                cell.replyTextField.placeholder = "Additional notes"
                
                return cell
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleTextFieldTableViewCell.identifier, for: indexPath) as! LifeStyleTextFieldTableViewCell
                cell.optionsLabel.text = "類型"
                cell.textField.placeholder = "添加"
                cell.textField.text = exerciseReplyArray[0]
                cell.textField.tag = 10 + indexPath.row
                cell.textField.delegate = self
                cell.textField.rightViewMode = .never
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleLabelTableViewCell.identifier, for: indexPath) as! LifeStyleLabelTableViewCell
                cell.optionsLabel.text = "時長"
                cell.replyLabel.text = exerciseReplyArray[1]
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleNoteTextFieldTableViewCell.identifier, for: indexPath) as! LifeStyleNoteTextFieldTableViewCell
                cell.optionsLabel.text = "註記"
                cell.replyTextField.text = exerciseReplyArray[2]
                cell.replyTextField.tag = 10 + indexPath.row
                cell.replyTextField.delegate = self
                cell.replyTextField.placeholder = "Additional notes"
                return cell
            }
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleLabelTableViewCell.identifier, for: indexPath) as! LifeStyleLabelTableViewCell
                cell.optionsLabel.text = "時長"
                cell.replyLabel.text = sleepReplyArray[0]
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleNoteTextFieldTableViewCell.identifier, for: indexPath) as! LifeStyleNoteTextFieldTableViewCell
                cell.optionsLabel.text = "註記"
                cell.replyTextField.text = sleepReplyArray[1]
                cell.replyTextField.tag = 20 + indexPath.row
                cell.replyTextField.delegate = self
                cell.replyTextField.placeholder = "Additional notes"
                return cell
            }
        case 3:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleTextFieldTableViewCell.identifier, for: indexPath) as! LifeStyleTextFieldTableViewCell
                let unitView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                let unitLabel = UILabel(frame: CGRect(x: 5, y: -1, width: 10, height: 20))
                unitLabel.text = "g"
                unitLabel.textColor = .facebook
                unitView.addSubview(unitLabel)
                cell.textField.rightView = unitView
                cell.textField.rightViewMode = .always
                cell.optionsLabel.text = "劑量"
                cell.textField.placeholder = "---"
                cell.textField.text = insulinRelyArray[0]
                cell.textField.tag = 30 + indexPath.row
                cell.textField.delegate = self
                cell.textField.keyboardType = .numberPad
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleNoteTextFieldTableViewCell.identifier, for: indexPath) as! LifeStyleNoteTextFieldTableViewCell
                cell.optionsLabel.text = "註記"
                cell.replyTextField.text = insulinRelyArray[1]
                cell.replyTextField.tag = 30 + indexPath.row
                cell.replyTextField.delegate = self
                cell.replyTextField.placeholder = "Additional notes"
                return cell
            }
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleNoteTextFieldTableViewCell.identifier, for: indexPath) as! LifeStyleNoteTextFieldTableViewCell
            cell.optionsLabel.text = "註記"
            cell.replyTextField.text = getUpReplayArray[0]
            cell.replyTextField.tag = 40 + indexPath.row
            cell.replyTextField.delegate = self
            cell.replyTextField.placeholder = "Additional notes"
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleNoteTextFieldTableViewCell.identifier, for: indexPath) as! LifeStyleNoteTextFieldTableViewCell
            cell.optionsLabel.text = "註記"
            cell.replyTextField.text = bathReplayArray[0]
            cell.replyTextField.tag = 50 + indexPath.row
            cell.replyTextField.delegate = self
            cell.replyTextField.placeholder = "Additional notes"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: LifeStyleNoteTextFieldTableViewCell.identifier, for: indexPath) as! LifeStyleNoteTextFieldTableViewCell
            cell.optionsLabel.text = "註記"
            cell.replyTextField.text = otherReplayArray[0]
            cell.replyTextField.tag = 60 + indexPath.row
            cell.replyTextField.delegate = self
            cell.replyTextField.placeholder = "Additional notes"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedEvenTitle == 0 || selectedEvenTitle == 1 {
            if indexPath.row == 2 {
                return 100
            } else {
                return 55
            }
        } else if selectedEvenTitle == 2 || selectedEvenTitle == 3 {
            if indexPath.row == 1 {
                return 100
            } else {
                return 55
            }
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedEvenTitle == 1 {
            if indexPath.row == 1 {
                timeView.isHidden = false
                datePicker.isHidden = true
                countDownPickerView.isHidden = false
            }
        } else if selectedEvenTitle == 2 {
            if indexPath.row == 0 {
                timeView.isHidden = false
                datePicker.isHidden = true
                countDownPickerView.isHidden = false
            }
        }
    }
    
}

//MARK: - PickerView
extension LifeStyleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return countDownHrArray.count
        } else if component == 2 {
            return countDownMinArray.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component == 0 {
            let title = UILabel()
            title.text = countDownHrArray[row]
            title.textAlignment = .center
            title.font = UIFont(name: "AppleSDGothicNeo-Light", size: 22)
            return title
        } else if component == 2 {
            let title = UILabel()
            title.text = countDownMinArray[row]
            title.font = UIFont(name: "AppleSDGothicNeo-Light", size: 22)
            title.textAlignment = .center
            return title
        } else if component == 1 {
            let title = UILabel()
            title.text = "小時"
            title.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 22)
            title.textAlignment = .right
            title.textColor = .black
            return title
        } else {
            let title = UILabel()
            title.text = "分鐘"
            title.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 22)
            title.textAlignment = .right
            title.textColor = .black
            return title
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 || component == 2 {
            return 40
        } else {
            return 50
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            if row > 9 {
                hr = countDownHrArray[row]
            } else {
                hr = "0\(countDownHrArray[row])"
            }
        } else if component == 2 {
            if row > 9 {
                min = countDownMinArray[row]
            } else {
                min = "0\(countDownMinArray[row])"
            }
        }
        countDownData = "\(hr):\(min)"
    }
    
}

//MARK: - TextField

extension LifeStyleViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        switch textField.tag {
        case 0:
            mealReplyArray[0] = text
        case 1:
            mealReplyArray[1] = text
        case 2:
            mealReplyArray[2] = text
        case 10:
            exerciseReplyArray[0] = text
        case 12:
            exerciseReplyArray[2] = text
        case 21:
            sleepReplyArray[1] = text
        case 30:
            insulinRelyArray[0] = text
        case 31:
            insulinRelyArray[1] = text
        case 40:
            getUpReplayArray[0] = text
        case 50:
            bathReplayArray[0] = text
        default:
            otherReplayArray[0] = text
        }
    }
}

// MARK: - Protocol


