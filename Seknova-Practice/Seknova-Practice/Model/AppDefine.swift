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
}
