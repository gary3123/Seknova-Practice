//
//  AppDefine.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/6.
//

import Foundation
import UIKit

class AppDefine {
    
    enum BodyInformation: Int, CaseIterable {
        case sex = 0, height, weight, race, drink, smoke
        
        var title: String {
            switch self {
            case .sex:
                return "性別"
            case .height:
                return "身高"
            case .weight:
                return "體重"
            case .race:
                return "種族"
            case .drink:
                return "飲酒"
            case .smoke:
                return "抽菸"
            }
        }
        
        var value: [String] {
            switch self {
            case .sex:
                return ["生理男", "生理女"]
            case .height:
                return []
            case .weight:
                return []
            case .race:
                return ["亞洲", "非洲", "高加索", "拉丁", "其他"]
            case .drink:
                return ["無", "偶爾", "頻繁", "每天"]
            case .smoke:
                return ["有", "無"]
            }
        }
    }
    
    enum PersonInformation: Int, CaseIterable {
        case firstName = 0, lastName, birthday, email, phone, address
        
        var title: String {
            switch self {
            case .firstName:
                return "名"
            case .lastName:
                return "姓"
            case .birthday:
                return "出生日期"
            case .email:
                return "電子信箱"
            case .phone:
                return "手機號碼"
            case .address:
                return "地址"
            }
        }
    }
    
    enum BodyInformationOption: Int, CaseIterable {
        case sex = 0, race, drink, smoke
    }
    
    enum NormalsettingOption: Int, CaseIterable {
        case alertSetting = 0, unitSwitching, bloodSugarWarning, dataSynchronize, warmUpStatus, eventLog, firmwareVersion, appVersion
        
        var title: String {
            switch self {
            case .alertSetting:
                return "警示設定"
            case .unitSwitching:
                return "單位切換(mmol/L)"
            case .bloodSugarWarning:
                return "超出高低血糖警示"
            case .dataSynchronize:
                return "資料同步"
            case .warmUpStatus:
                return "暖機狀態"
            case .eventLog:
                return "韌體版本"
            case .firmwareVersion:
                return "韌體版本"
            case .appVersion:
                return "App 版本"
            }
        }
    }
    
    enum DevelopsettingOption: Int, CaseIterable {
        case alertSetting = 0, calibrationmode, ADCInitialValue, xAxisTimeInterval, yAxisLimit, unitSwitching, showNumericalInformation, showRSSI, uploadCloud, bloodSugarWarning, dataSynchronize, warmUpStatus, eventLog, firmwareVersion, appVersion
        
        var title: String {
            switch self {
            case .alertSetting:
                return "警示設定"
            case .unitSwitching:
                return "單位切換(mmol/L)"
            case .bloodSugarWarning:
                return "超出高低血糖警示"
            case .dataSynchronize:
                return "資料同步"
            case .warmUpStatus:
                return "暖機狀態"
            case .eventLog:
                return "上傳事件日誌"
            case .firmwareVersion:
                return "韌體版本"
            case .appVersion:
                return "App 版本"
            case .calibrationmode:
                return "校正模式"
            case .ADCInitialValue:
                return "設定ADC初始值"
            case .xAxisTimeInterval:
                return "設定X軸時間間距 (per/s)"
            case .yAxisLimit:
                return "設定y軸上下限"
            case .showNumericalInformation:
                return "顯示數值資訊"
            case .showRSSI:
                return "顯示 RSSI"
            case .uploadCloud:
                return "上傳雲端"
            }
        }
    }
    
    enum SettingAlert: Int, CaseIterable {
        case highAlerts = 0, lowAlerts, rateAlerts, audio
        
        var title: String {
            switch self {
            case .highAlerts:
                return "High Alerts"
            case .lowAlerts:
                return "Low Alerts"
            case .rateAlerts:
                return "Rate Alerts"
            case .audio:
                return "Audio"
            }
        }
    }
    
    enum EventID: Int, CaseIterable {
        case Meal = 2       //用餐
        case Exercise = 3   //運動
        case Sleep = 4      //睡覺
        case Insulin = 5    //胰島素
        case GetUp = 6      //起床
        case Bath = 7       //洗澡
        case Other = 8      //其他
    }
    
    typealias EventType = (eventID: EventID, eventValue: Int, eventValueData: String)
    enum MealEventValue: Int, CaseIterable {
        case Breakfast = 0, Lunch, Dinner, Snack, Drink
        
        var value: EventType {
            switch self {
            case .Breakfast:
                return (.Meal, 0, NSLocalizedString("Breakfast", comment: ""))
            case .Lunch:
                return (.Meal, 1, NSLocalizedString("Lunch", comment: ""))
            case .Dinner:
                return (.Meal, 2, NSLocalizedString("Dinner", comment: ""))
            case .Snack:
                return (.Meal, 3, NSLocalizedString("Snack", comment: ""))
            case .Drink:
                return (.Meal, 4, NSLocalizedString("Drink", comment: ""))
            }
        }
    }
    
    enum ExerciseEventValue: Int, CaseIterable {
        case High = 0, Medium, Low
        
        var value: EventType {
            switch self {
            case .High:
                return (.Exercise, 0, NSLocalizedString("High", comment: ""))
            case .Medium:
                return (.Exercise, 1, NSLocalizedString("Medium", comment: ""))
            case .Low:
                return (.Exercise, 2, NSLocalizedString("Low", comment: ""))
            }
        }
    }
    
    enum InsulinEventValue: Int, CaseIterable {
        case Rapid = 0, Long, Unspecified
        
        var value: EventType {
            switch self {
            case .Rapid:
                return (.Insulin, 0, NSLocalizedString("Rapid", comment: ""))
            case .Long:
                return (.Insulin, 1, NSLocalizedString("Long", comment: ""))
            case .Unspecified:
                return (.Insulin, 2, NSLocalizedString("Unspecified", comment: ""))
            }
        }
    }
    
    enum SleepEventValue: Int, CaseIterable {
        case Sleep = 0, Nap, Rest, RelaxTime
        
        var value: EventType {
            switch self {
            case .Sleep:
                return (.Sleep, 0, NSLocalizedString("Sleep", comment: ""))
            case .Nap:
                return (.Sleep, 1, NSLocalizedString("Nap", comment: ""))
            case .Rest:
                return (.Sleep, 2, NSLocalizedString("Rest", comment: ""))
            case .RelaxTime:
                return (.Sleep, 3, NSLocalizedString("RelaxTime", comment: ""))
            }
        }
    }
    
    enum Other: Int, CaseIterable {
        case Getup = 0, Bath, Other
        var value: EventType {
            switch self {
            case .Getup:
                return (.GetUp, 10, NSLocalizedString("Getup", comment: ""))
            case .Bath:
                return (.Bath, 10, NSLocalizedString("Bath", comment: ""))
            case .Other:
                return (.Other, 0, NSLocalizedString("Others", comment: ""))
            }
        }
    }
}
