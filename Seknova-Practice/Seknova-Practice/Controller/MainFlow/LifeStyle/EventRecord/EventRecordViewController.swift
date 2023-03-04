//
//  EventRecordViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/15.
//

import UIKit
import RealmSwift


class EventRecordViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Variables
    var isExpand = false
    var selectZeroRow = [0,-1]
    var selectOneRow = [1,-1]
    let realm = try! Realm()
    var tableViewCellType = 0
    var deleteStatus = false
    let deleteButtonItem = UIButton(type: .custom) // NavigationBar 的刪除鍵
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        view.insertSubview(AlphaBackgroundView(imageName: "Background5.jpg", alpha: 0.2), at: 0)
        
        self.title = "事件記錄"
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        setupNavigationBar()
        setupTableView()
    }
    
    
    func setupNavigationBar() {
        deleteButtonItem.setTitle("刪除", for: .normal)
        deleteButtonItem.addTarget(self, action: #selector(clickDeleteBarButtonItem), for: .touchUpInside)
        let buttonView = UIBarButtonItem(customView: deleteButtonItem)
        // 設定寬
        let buttonViewWidth = buttonView.customView?.widthAnchor.constraint(equalToConstant: 40)
        buttonViewWidth?.isActive = true
        // 設定高
        let buttonViewHeight = buttonView.customView?.heightAnchor.constraint(equalToConstant: 24)
        buttonViewHeight?.isActive = true
        navigationItem.setRightBarButton(buttonView, animated: true)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OtherEventTableViewCell", bundle: nil), forCellReuseIdentifier: OtherEventTableViewCell.identifier)
        tableView.register(UINib(nibName: "MealTableViewCell", bundle: nil), forCellReuseIdentifier: MealTableViewCell.identifier)
        tableView.register(UINib(nibName: "ExerciseTableViewCell", bundle: nil), forCellReuseIdentifier: ExerciseTableViewCell.identifier)
        tableView.register(UINib(nibName: "SleepTableViewCell", bundle: nil), forCellReuseIdentifier: SleepTableViewCell.identifier)
        tableView.register(UINib(nibName: "InsulinTableViewCell", bundle: nil), forCellReuseIdentifier: InsulinTableViewCell.identifier)
        
    }
    
    func todayAndYesterday(formatter: String) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_TW")
        dateFormatter.dateFormat = formatter
        let today = dateFormatter.string(from: Date())
        let yesterdayDate = Date.init(timeInterval: -24 * 60 * 60, since: Date())
        let yesterday = dateFormatter.string(from: yesterdayDate)
        return ["\(today)","\(yesterday)"]
    }
    
    func displayEventTitle(eventId: Int) -> String {
        switch eventId {
        case 2:
            return "用餐"
        case 3:
            return "運動"
        case 4:
            return "睡眠"
        case 5:
            return "胰島素"
        case 6:
            return "起床"
        case 7:
            return "洗澡"
        default:
            return "其他"
        }
    }
    
    func displayEventSubtitle(eventId: Int,
                              eventValue: Int) -> String {
        switch eventId {
        case 2:
            switch eventValue {
            case 0:
                return "早餐"
            case 1:
                return "午餐"
            case 2:
                return "晚餐"
            case 3:
                return "點心"
            default:
                return "飲料"
            }
        case 3:
            switch eventValue {
            case 0:
                return "高強度"
            case 1:
                return "中強度"
            default:
                return "低強度"
            }
        case 4:
            switch eventValue {
            case 0:
                return "就寢"
            case 1:
                return "午睡"
            case 2:
                return "小憩"
            default:
                return "放鬆時刻"
            }
        case 5:
            switch eventValue {
            case 0:
                return "速效型"
            case 1:
                return "長效型"
            default:
                return "未指定"
            }
        case 6:
            switch eventValue {
            default:
                return "起床"
            }
        case 7:
            switch eventValue {
            default:
                return "洗澡"
            }
        default:
            switch eventValue {
            default:
                return "其他"
            }
        }
    }
    
    // MARK: - IBAction
    @objc func clickDeleteBarButtonItem() {
        if deleteStatus == true {
            deleteButtonItem.setTitle("刪除", for: .normal)
            deleteStatus.toggle()
        } else {
            deleteButtonItem.setTitle("編輯", for: .normal)
            deleteStatus.toggle()
        }
        tableView.reloadData()
    }
    
    @objc func clickEditAndDeleteButton(_ sender: UIButton) {
        let todayAndYesterday = todayAndYesterday(formatter: "MM/dd")
        let todayEventTable = realm.objects(EventData.self).filter("dateTime CONTAINS '\(todayAndYesterday[0])'")
        let yesterdayEventTable = realm.objects(EventData.self).filter("dateTime CONTAINS '\(todayAndYesterday[1])'")
        if deleteStatus == true {
            print("tag: \(sender.tag)")
            if todayEventTable.count == 0 {
                try! realm.write {
                    realm.delete(yesterdayEventTable[sender.tag])
                }
            } else {
                if sender.tag >= todayEventTable.count {
                    try! realm.write {
                        realm.delete(yesterdayEventTable[sender.tag - todayEventTable.count])
                    }
                } else {
                    try! realm.write {
                        realm.delete(todayEventTable[sender.tag])
                    }
                }
            }
            tableView.reloadData()
        } else {
            print("tag: \(sender.tag)")
            if todayEventTable.count == 0 {
                var attribute: [String] = []
                for i in 0 ..< yesterdayEventTable[sender.tag].eventAttribute.count {
                    attribute.append(yesterdayEventTable[sender.tag].eventAttribute[i])
                }
                let nextVC = LifeStyleViewController()
                nextVC.alterStatus = true
                nextVC.alterRowValue = sender.tag
                nextVC.alterEventId = yesterdayEventTable[sender.tag].eventId
                nextVC.alterEventValue = yesterdayEventTable[sender.tag].eventValue
                nextVC.alterDateTime = yesterdayEventTable[sender.tag].dateTime
                nextVC.alterAttribute = attribute
                navigationController?.pushViewController(nextVC, animated: true)
            } else {
                if sender.tag >= todayEventTable.count {
                    var attribute: [String] = []
                    for i in 0 ..< yesterdayEventTable[sender.tag - todayEventTable.count].eventAttribute.count {
                        attribute.append(yesterdayEventTable[sender.tag - todayEventTable.count].eventAttribute[i])
                    }
                    let nextVC = LifeStyleViewController()
                    nextVC.alterStatus = true
                    nextVC.alterRowValue = sender.tag - todayEventTable.count
                    nextVC.alterEventId = yesterdayEventTable[sender.tag - todayEventTable.count].eventId
                    nextVC.alterEventValue = yesterdayEventTable[sender.tag - todayEventTable.count].eventValue
                    nextVC.alterDateTime = yesterdayEventTable[sender.tag - todayEventTable.count].dateTime
                    nextVC.alterAttribute = attribute
                    navigationController?.pushViewController(nextVC, animated: true)
                    
                } else {
                    var attribute: [String] = []
                    for i in 0 ..< todayEventTable[sender.tag].eventAttribute.count {
                        attribute.append(todayEventTable[sender.tag].eventAttribute[i])
                    }
                    let nextVC = LifeStyleViewController()
                    nextVC.alterStatus = true
                    nextVC.alterRowValue = sender.tag
                    nextVC.alterEventId = todayEventTable[sender.tag].eventId
                    nextVC.alterEventValue = todayEventTable[sender.tag].eventValue
                    nextVC.alterDateTime = todayEventTable[sender.tag].dateTime
                    nextVC.alterAttribute = attribute
                    navigationController?.pushViewController(nextVC, animated: true)
                }
            }
        }
    }
    
}

// MARK: - TableView
extension EventRecordViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let displayDate: [String] = todayAndYesterday(formatter: "yyyy/MM/dd")
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let label = UILabel()
        label.frame = CGRect.init(x: 0 , y: 0, width: headerView.frame.width, height: headerView.frame.height - 10)
        label.text = displayDate[section]
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .black
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let todayAndYesterday = todayAndYesterday(formatter: "MM/dd")
        let todayEventTable = realm.objects(EventData.self).filter("dateTime CONTAINS '\(todayAndYesterday[0])'")
        let yesterdayEventTable = realm.objects(EventData.self).filter("dateTime CONTAINS '\(todayAndYesterday[1])'")
        if section == 0 {
            return todayEventTable.count
        } else {
            return yesterdayEventTable.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // section 0
        //設定 Realm 查詢的資料表
        let todayAndYesterday = todayAndYesterday(formatter: "MM/dd")
        let todayEventTable = realm.objects(EventData.self).filter("dateTime CONTAINS '\(todayAndYesterday[0])'")
        let yesterdayEventTable = realm.objects(EventData.self).filter("dateTime CONTAINS '\(todayAndYesterday[1])'")
        
        // 設定顯示的時間格式
        let cellDisplayTimeFormatter = DateFormatter()
        let realmDateTimeFormatter = DateFormatter()
        realmDateTimeFormatter.dateFormat = "yyyy/MM/dd EEEE a hh:mm"
        realmDateTimeFormatter.locale = Locale(identifier: "zh_TW")
        cellDisplayTimeFormatter.dateFormat = "MM/dd hh:mm a"
        cellDisplayTimeFormatter.locale = Locale(identifier: "zh_TW")
        
        if indexPath.section == 0 {
            
            if todayEventTable[indexPath.row].eventId == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as! MealTableViewCell
                let eventValue = displayEventSubtitle(eventId: todayEventTable[indexPath.row].eventId, eventValue: todayEventTable[indexPath.row].eventValue)
                let cellTodayDisplayTime = cellDisplayTimeFormatter.string(from:  realmDateTimeFormatter.date(from: todayEventTable[indexPath.row].dateTime)!)
                cell.dateTimeLabel.text = cellTodayDisplayTime
                //個別設定不一樣事件的值
                cell.eventSubtitleLabel.text = eventValue
                cell.nameReplyLabel.text = todayEventTable[indexPath.row].eventAttribute[1]
                cell.quantityReplyLabel.text = todayEventTable[indexPath.row].eventAttribute[2]
                cell.noteReplyLabel.text = todayEventTable[indexPath.row].note
                
                if deleteStatus == false {
                    cell.editAndDeleteButton.setImage(UIImage(named: "edit"), for: .normal)
                } else {
                    cell.editAndDeleteButton.setImage(UIImage(named: "waste"), for: .normal)
                }
                
                if selectZeroRow == [indexPath.section,indexPath.row] {
                    cell.expand()
                } else {
                    cell.close()
                }
                tableViewCellType = todayEventTable[indexPath.row].eventId
                cell.editAndDeleteButton.tag = indexPath.row //區分兩個 section 不一樣的 tag
                cell.editAndDeleteButton.addTarget(self, action: #selector(clickEditAndDeleteButton), for: .touchUpInside)
                return cell
            } else if todayEventTable[indexPath.row].eventId == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.identifier, for: indexPath) as! ExerciseTableViewCell
                let eventValue = displayEventSubtitle(eventId: todayEventTable[indexPath.row].eventId, eventValue: todayEventTable[indexPath.row].eventValue)
                let cellTodayDisplayTime = cellDisplayTimeFormatter.string(from:  realmDateTimeFormatter.date(from: todayEventTable[indexPath.row].dateTime)!)
                cell.dateTimeLabel.text = cellTodayDisplayTime
                cell.eventSubtitleLabel.text = eventValue
                cell.typeReplyLabel.text = todayEventTable[indexPath.row].eventAttribute[1]
                cell.durationReplyLabel.text = todayEventTable[indexPath.row].eventAttribute[2]
                cell.noteReplyLabel.text = todayEventTable[indexPath.row].note
                
                if deleteStatus == false {
                    cell.editAndDeleteButton.setImage(UIImage(named: "edit"), for: .normal)
                } else {
                    cell.editAndDeleteButton.setImage(UIImage(named: "waste"), for: .normal)
                }
                
                if selectZeroRow ==  [indexPath.section,indexPath.row] {
                    cell.expand()
                } else {
                    cell.close()
                }
                tableViewCellType = todayEventTable[indexPath.row].eventId
                cell.editAndDeleteButton.tag = indexPath.row
                cell.editAndDeleteButton.addTarget(self, action: #selector(clickEditAndDeleteButton), for: .touchUpInside)
                return cell
            } else if todayEventTable[indexPath.row].eventId == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: SleepTableViewCell.identifier, for: indexPath) as! SleepTableViewCell
                let eventValue = displayEventSubtitle(eventId: todayEventTable[indexPath.row].eventId, eventValue: todayEventTable[indexPath.row].eventValue)
                let cellTodayDisplayTime = cellDisplayTimeFormatter.string(from:  realmDateTimeFormatter.date(from: todayEventTable[indexPath.row].dateTime)!)
                cell.dateTimeLabel.text = cellTodayDisplayTime
                cell.eventSubtitleLabel.text = eventValue
                cell.durationReplyLabel.text = todayEventTable[indexPath.row].eventAttribute[1]
                cell.noteReplyLabel.text = todayEventTable[indexPath.row].note
                
                if deleteStatus == false {
                    cell.editAndDeleteButton.setImage(UIImage(named: "edit"), for: .normal)
                } else {
                    cell.editAndDeleteButton.setImage(UIImage(named: "waste"), for: .normal)
                }
                
                if selectZeroRow ==  [indexPath.section,indexPath.row] {
                    cell.expand()
                } else {
                    cell.close()
                }
                tableViewCellType = todayEventTable[indexPath.row].eventId
                cell.editAndDeleteButton.tag = indexPath.row
                cell.editAndDeleteButton.addTarget(self, action: #selector(clickEditAndDeleteButton), for: .touchUpInside)
                return cell
            } else if todayEventTable[indexPath.row].eventId == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: InsulinTableViewCell.identifier, for: indexPath) as! InsulinTableViewCell
                let eventValue = displayEventSubtitle(eventId: todayEventTable[indexPath.row].eventId, eventValue: todayEventTable[indexPath.row].eventValue)
                let cellTodayDisplayTime = cellDisplayTimeFormatter.string(from:  realmDateTimeFormatter.date(from: todayEventTable[indexPath.row].dateTime)!)
                cell.dateTimeLabel.text = cellTodayDisplayTime
                cell.eventSubtitleLabel.text = eventValue
                cell.doseReplyLabel.text = todayEventTable[indexPath.row].eventAttribute[1]
                cell.noteReplyLabel.text = todayEventTable[indexPath.row].note
                
                if deleteStatus == false {
                    cell.editAndDeleteButton.setImage(UIImage(named: "edit"), for: .normal)
                } else {
                    cell.editAndDeleteButton.setImage(UIImage(named: "waste"), for: .normal)
                }
                
                if selectZeroRow ==  [indexPath.section,indexPath.row] {
                    cell.expand()
                } else {
                    cell.close()
                }
                tableViewCellType = todayEventTable[indexPath.row].eventId
                cell.editAndDeleteButton.tag = indexPath.row
                cell.editAndDeleteButton.addTarget(self, action: #selector(clickEditAndDeleteButton), for: .touchUpInside)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: OtherEventTableViewCell.identifier, for: indexPath) as! OtherEventTableViewCell
                let eventValue = displayEventSubtitle(eventId: todayEventTable[indexPath.row].eventId, eventValue: todayEventTable[indexPath.row].eventValue)
                cell.eventSubtitleLabel.text = eventValue
                let cellTodayDisplayTime = cellDisplayTimeFormatter.string(from:  realmDateTimeFormatter.date(from: todayEventTable[indexPath.row].dateTime)!)
                cell.dateTimeLabel.text = cellTodayDisplayTime
                cell.noteReplyLabel.text = todayEventTable[indexPath.row].note
                
                if deleteStatus == false {
                    cell.editAndDeleteButton.setImage(UIImage(named: "edit"), for: .normal)
                } else {
                    cell.editAndDeleteButton.setImage(UIImage(named: "waste"), for: .normal)
                }
                
                if selectZeroRow ==  [indexPath.section,indexPath.row] {
                    cell.expand()
                } else {
                    cell.close()
                }
                tableViewCellType = todayEventTable[indexPath.row].eventId
                cell.editAndDeleteButton.tag = indexPath.row
                cell.editAndDeleteButton.addTarget(self, action: #selector(clickEditAndDeleteButton), for: .touchUpInside)
                return cell
            }
        } else {
            // section 1
            if yesterdayEventTable[indexPath.row].eventId == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as! MealTableViewCell
                let eventValue = displayEventSubtitle(eventId: yesterdayEventTable[indexPath.row].eventId, eventValue: yesterdayEventTable[indexPath.row].eventValue)
                let cellYesterdayDisplayTime = cellDisplayTimeFormatter.string(from:  realmDateTimeFormatter.date(from: yesterdayEventTable[indexPath.row].dateTime)!)
                cell.dateTimeLabel.text = cellYesterdayDisplayTime
                //個別設定不一樣事件的值
                cell.eventSubtitleLabel.text = eventValue
                cell.nameReplyLabel.text = yesterdayEventTable[indexPath.row].eventAttribute[1]
                cell.quantityReplyLabel.text = yesterdayEventTable[indexPath.row].eventAttribute[2]
                cell.noteReplyLabel.text = yesterdayEventTable[indexPath.row].note
                
                if deleteStatus == false {
                    cell.editAndDeleteButton.setImage(UIImage(named: "edit"), for: .normal)
                } else {
                    cell.editAndDeleteButton.setImage(UIImage(named: "waste"), for: .normal)
                }
                
                if selectOneRow == [indexPath.section,indexPath.row] {
                    cell.expand()
                } else {
                    cell.close()
                }
                tableViewCellType = yesterdayEventTable[indexPath.row].eventId
                if todayEventTable.count == 0 {
                    cell.editAndDeleteButton.tag = indexPath.row
                } else {
                    cell.editAndDeleteButton.tag = todayEventTable.count + indexPath.row
                } //區分兩個 section 不一樣的 tag
                cell.editAndDeleteButton.addTarget(self, action: #selector(clickEditAndDeleteButton), for: .touchUpInside)
                return cell
            } else if yesterdayEventTable[indexPath.row].eventId == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.identifier, for: indexPath) as! ExerciseTableViewCell
                let eventValue = displayEventSubtitle(eventId: yesterdayEventTable[indexPath.row].eventId, eventValue: yesterdayEventTable[indexPath.row].eventValue)
                let cellYesterdayDisplayTime = cellDisplayTimeFormatter.string(from:  realmDateTimeFormatter.date(from: yesterdayEventTable[indexPath.row].dateTime)!)
                cell.dateTimeLabel.text = cellYesterdayDisplayTime
                cell.eventSubtitleLabel.text = eventValue
                cell.typeReplyLabel.text = yesterdayEventTable[indexPath.row].eventAttribute[1]
                cell.durationReplyLabel.text = yesterdayEventTable[indexPath.row].eventAttribute[2]
                cell.noteReplyLabel.text = yesterdayEventTable[indexPath.row].note
                
                if deleteStatus == false {
                    cell.editAndDeleteButton.setImage(UIImage(named: "edit"), for: .normal)
                } else {
                    cell.editAndDeleteButton.setImage(UIImage(named: "waste"), for: .normal)
                }
                
                if selectOneRow == [indexPath.section,indexPath.row] {
                    cell.expand()
                } else {
                    cell.close()
                }
                tableViewCellType = yesterdayEventTable[indexPath.row].eventId
                if todayEventTable.count == 0 {
                    cell.editAndDeleteButton.tag = indexPath.row
                } else {
                    cell.editAndDeleteButton.tag = todayEventTable.count + indexPath.row
                }
                cell.editAndDeleteButton.addTarget(self, action: #selector(clickEditAndDeleteButton), for: .touchUpInside)
                return cell
            } else if yesterdayEventTable[indexPath.row].eventId == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: SleepTableViewCell.identifier, for: indexPath) as! SleepTableViewCell
                let eventValue = displayEventSubtitle(eventId: yesterdayEventTable[indexPath.row].eventId, eventValue: yesterdayEventTable[indexPath.row].eventValue)
                let cellYesterdayDisplayTime = cellDisplayTimeFormatter.string(from:  realmDateTimeFormatter.date(from: todayEventTable[indexPath.row].dateTime)!)
                cell.dateTimeLabel.text = cellYesterdayDisplayTime
                cell.eventSubtitleLabel.text = eventValue
                cell.durationReplyLabel.text = yesterdayEventTable[indexPath.row].eventAttribute[1]
                cell.noteReplyLabel.text = yesterdayEventTable[indexPath.row].note
                
                if deleteStatus == false {
                    cell.editAndDeleteButton.setImage(UIImage(named: "edit"), for: .normal)
                } else {
                    cell.editAndDeleteButton.setImage(UIImage(named: "waste"), for: .normal)
                }
                
                if selectOneRow == [indexPath.section,indexPath.row] {
                    cell.expand()
                } else {
                    cell.close()
                }
                tableViewCellType = yesterdayEventTable[indexPath.row].eventId
                if todayEventTable.count == 0 {
                    cell.editAndDeleteButton.tag = indexPath.row
                } else {
                    cell.editAndDeleteButton.tag = todayEventTable.count + indexPath.row
                }
                cell.editAndDeleteButton.addTarget(self, action: #selector(clickEditAndDeleteButton), for: .touchUpInside)
                return cell
            } else if yesterdayEventTable[indexPath.row].eventId == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: InsulinTableViewCell.identifier, for: indexPath) as! InsulinTableViewCell
                let eventValue = displayEventSubtitle(eventId: yesterdayEventTable[indexPath.row].eventId, eventValue: yesterdayEventTable[indexPath.row].eventValue)
                let cellYesterdayDisplayTime = cellDisplayTimeFormatter.string(from:  realmDateTimeFormatter.date(from: yesterdayEventTable[indexPath.row].dateTime)!)
                cell.dateTimeLabel.text = cellYesterdayDisplayTime
                cell.eventSubtitleLabel.text = eventValue
                cell.doseReplyLabel.text = yesterdayEventTable[indexPath.row].eventAttribute[1]
                cell.noteReplyLabel.text = yesterdayEventTable[indexPath.row].note
                
                if deleteStatus == false {
                    cell.editAndDeleteButton.setImage(UIImage(named: "edit"), for: .normal)
                } else {
                    cell.editAndDeleteButton.setImage(UIImage(named: "waste"), for: .normal)
                }
                
                if selectOneRow == [indexPath.section,indexPath.row] {
                    cell.expand()
                } else {
                    cell.close()
                }
                tableViewCellType = yesterdayEventTable[indexPath.row].eventId
                if todayEventTable.count == 0 {
                    cell.editAndDeleteButton.tag = indexPath.row
                } else {
                    cell.editAndDeleteButton.tag = todayEventTable.count + indexPath.row
                }
                cell.editAndDeleteButton.addTarget(self, action: #selector(clickEditAndDeleteButton), for: .touchUpInside)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: OtherEventTableViewCell.identifier, for: indexPath) as! OtherEventTableViewCell
                let eventValue = displayEventSubtitle(eventId: yesterdayEventTable[indexPath.row].eventId, eventValue: yesterdayEventTable[indexPath.row].eventValue)
                cell.eventSubtitleLabel.text = eventValue
                let cellYesterdayDisplayTime = cellDisplayTimeFormatter.string(from:  realmDateTimeFormatter.date(from: yesterdayEventTable[indexPath.row].dateTime)!)
                cell.dateTimeLabel.text = cellYesterdayDisplayTime
                cell.noteReplyLabel.text = yesterdayEventTable[indexPath.row].note
                
                if deleteStatus == false {
                    cell.editAndDeleteButton.setImage(UIImage(named: "edit"), for: .normal)
                } else {
                    cell.editAndDeleteButton.setImage(UIImage(named: "waste"), for: .normal)
                }
                
                if selectOneRow == [indexPath.section,indexPath.row] {
                    cell.expand()
                } else {
                    cell.close()
                }
                tableViewCellType = todayEventTable[indexPath.row].eventId
                if todayEventTable.count == 0 {
                    cell.editAndDeleteButton.tag = indexPath.row
                } else {
                    cell.editAndDeleteButton.tag = todayEventTable.count + indexPath.row
                }
                cell.editAndDeleteButton.addTarget(self, action: #selector(clickEditAndDeleteButton), for: .touchUpInside)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            selectZeroRow = [0,indexPath.row]
            selectOneRow = [1,-1]
        } else {
            selectOneRow = [1,indexPath.row]
            selectZeroRow = [0,-1]
        }
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if selectZeroRow == [0,indexPath.row] {
                if tableViewCellType == 2 || tableViewCellType == 3{
                    return 160
                } else if tableViewCellType == 4 || tableViewCellType == 5 {
                    return 140
                } else {
                    return 60
                }
            } else {
                return 60
            }
        } else {
            if selectOneRow == [1,indexPath.row] {
                if tableViewCellType == 2 || tableViewCellType == 3{
                    return 160
                } else if tableViewCellType == 4 || tableViewCellType == 5 {
                    return 140
                } else {
                    return 60
                }
            } else {
                return 60
            }
        }
    }
}

// MARK: - Protocol

