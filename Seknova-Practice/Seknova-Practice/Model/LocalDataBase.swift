//
//  LocalDataBase.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/9.
//

import Foundation
import UIKit
import RealmSwift

class Records: Object {
    @Persisted var count: Int = 0
    @Persisted var recordTime: String = ""
    @Persisted var displayTime: String = ""
    @Persisted var tempertaute: Int = 0
    @Persisted var adc1: Int = 0
    @Persisted var adc2: Int = 0
    @Persisted var battery: Int = 0
    @Persisted var check: Bool = false
    @Persisted var calibrated: Bool = false
    
    convenience init(count: Int,
                     recordTime: String,
                     displayTime: String,
                     tempertaute: Int,
                     adc1: Int,
                     adc2: Int,
                     battery: Int,
                     check: Bool,
                     calibrated: Bool) {
        self.init();
        self.count = count
        self.recordTime = recordTime
        self.displayTime = displayTime
        self.tempertaute = tempertaute
        self.adc1 = adc1
        self.adc2 = adc2
        self.battery = battery
        self.check = check
        self.calibrated = calibrated
    }
}


class EventData: Object {
    @Persisted var id: Int = 0
    @Persisted var dateTime: String = ""
    @Persisted var displayTime: String = ""
    @Persisted var eventId: Int = 0
    @Persisted var eventValue: Int = 0
    @Persisted var note: String = ""
    @Persisted var check: Bool = false
    
    convenience init(id: Int,
                     dateTime: String,
                     displayTime: String,
                     eventId: Int,
                     eventValue: Int,
                     note: String,
                     check: Bool) {
        self.init();
        self.id = id
        self.dateTime = dateTime
        self.displayTime = displayTime
        self.eventId = eventId
        self.eventValue = eventValue
        self.check = check
    }
}

class UserInformation: Object {
    @Persisted var userId: String = ""
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var birthday: String = ""
    @Persisted var email: String = ""
    @Persisted var phone: String = ""
    @Persisted var address: String = ""
    @Persisted var gender: Int = 0
    @Persisted var height: Int = 0
    @Persisted var weight: Int = 0
    @Persisted var race: Int = 0
    @Persisted var liquor: Int = 0
    @Persisted var smoke: Bool = false
    @Persisted var check: Bool = false
    @Persisted var phone_Verified: Bool = false
    @Persisted var finishCalibrateTime: Int64 = 0
    @Persisted var nextCalibrateInterval: Int64 = 0
    @Persisted var lastRecordCount: String = "00000000"
    @Persisted var firstRecordCount: String = "00000000"
    @Persisted var resetCount: Int = 0
    
    convenience init(userId: String,
                     firstName: String,
                     lastName: String,
                     birthday: String,
                     email: String,
                     phone: String,
                     address: String,
                     gender: Int,
                     height: Int,
                     weight: Int,
                     race: Int,
                     liquor: Int,
                     smoke: Bool,
                     check: Bool,
                     phone_Verified: Bool,
                     finishCalibrateTime: Int64,
                     nextCalibrateInterval: Int64,
                     lastRecordCount: String,
                     firstRecordCount: String,
                     resetCount: Int) {
        self.init()
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.birthday = birthday
        self.email = email
        self.phone = phone
        self.address = address
        self.gender = gender
        self.height = height
        self.weight = weight
        self.race = race
        self.liquor = liquor
        self.smoke = smoke
        self.check = check
        self.phone_Verified = phone_Verified
        self.finishCalibrateTime = finishCalibrateTime
        self.nextCalibrateInterval = nextCalibrateInterval
        self.lastRecordCount = lastRecordCount
        self.firstRecordCount = firstRecordCount
        self.resetCount = resetCount
    }
}

class CalibrationModeData: Object {
    @Persisted var modeID: Int = 0
    @Persisted var rawData2BGBias: Int = 100
    @Persisted var BGBias: Int = 100
    @Persisted var BGLow: Int = 40
    @Persisted var BGHigh: Int = 400
    @Persisted var mapRate: Int = 1
    @Persisted var thresholdRise: Int = 50
    @Persisted var thresholdFall: Int = 50
    @Persisted var riseRate: Int = 100
    @Persisted var fallenRate: Int = 100
    
    convenience init(modeID: Int,
                     rawData2BGBias: Int,
                     BGBias: Int,
                     BGLow: Int,
                     BGHigh: Int,
                     mapRate: Int,
                     thresholdRise: Int,
                     thresholdFall: Int,
                     riseRate: Int,
                     fallenRate: Int) {
        
        self.init()
        self.modeID = modeID
        self.rawData2BGBias = rawData2BGBias
        self.BGBias = BGBias
        self.BGLow = BGLow
        self.mapRate = mapRate
        self.thresholdRise = thresholdRise
        self.thresholdFall = thresholdFall
        self.riseRate = riseRate
        self.fallenRate = fallenRate
    }
}
