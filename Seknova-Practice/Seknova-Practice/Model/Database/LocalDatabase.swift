//
//  LocalDatabase.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/9.
//

import Foundation
import RealmSwift

class LocalDatabase: NSObject {
    
    static let shared = LocalDatabase()
    
// MARK: Add - Fuction
    func addEvenData(eventData: EventDataTable) {
        let realm = try! Realm()
        
        let eventDataTable = EventData()
        eventDataTable.id = eventData.id
        eventDataTable.dateTime = eventData.dateTime
        eventDataTable.displayTime = eventData.displayTime
        eventDataTable.eventId = eventData.eventId
        eventDataTable.eventValue = eventData.eventValue
        eventData.eventAttribute.forEach { attribute in
            eventDataTable.eventAttribute.append(attribute)
        }
        eventDataTable.note = eventData.note
        eventDataTable.check = eventData.check
        
        do {
            try! realm.write {
                realm.add(eventDataTable)
                print("Realm.Add Success fileURL:\(realm.configuration.fileURL)")
            }
        } catch {
            print("Realm.Add Fail, Error:\(error.localizedDescription)")
        }
    }
    
    func addRecords(records: RecordsTable) {
        let realm = try! Realm()
        
        let recordsTable = Records()
        recordsTable.count = records.count
        recordsTable.recordTime = records.recordTime
        recordsTable.displayTime = records.displayTime
        recordsTable.tempertaute = records.tempertaute
        recordsTable.adc1 = records.adc1
        recordsTable.battery = records.battery
        recordsTable.check = records.check
        recordsTable.calibrated = records.calibrated
    }
    
    func addUserInformation(userInformation: UserInformationTable) {
        let realm = try! Realm()
        
        let userInformationTable = UserInformation()
        userInformationTable.userId = userInformation.userId
        userInformationTable.firstName = userInformation.firstName
        userInformationTable.lastName = userInformation.lastName
        userInformationTable.birthday = userInformation.birthady
        userInformationTable.email = userInformation.email
        userInformationTable.phone = userInformation.phone
        userInformationTable.address = userInformation.address
        userInformationTable.gender = userInformation.gender
        userInformationTable.height = userInformation.height
        userInformationTable.weight = userInformation.weight
        userInformationTable.race = userInformation.race
        userInformationTable.liquor = userInformation.liquor
        userInformationTable.smoke = userInformation.smoke
        userInformationTable.check = userInformation.check
        userInformationTable.phone_Verified = userInformation.phone_Verified
        
        do {
            try! realm.write {
                realm.add(userInformationTable)
                print("Realm.Add Success fileURL:\(realm.configuration.fileURL)")
            }
        } catch {
            print("Realm.Add Fail, Error:\(error.localizedDescription)")
        }
    }
    
    func addCalibrationModeData(calibrationModeData: CalibrationModeDataTable) {
        let realm = try! Realm()
        let calibrationModeDataTable = CalibrationModeData()
        calibrationModeDataTable.modeID = calibrationModeData.modeID
        calibrationModeDataTable.rawData2BGBias = calibrationModeData.rawData2BGBias
        calibrationModeDataTable.BGBias = calibrationModeData.BGBias
        calibrationModeDataTable.BGLow = calibrationModeData.BGLow
        calibrationModeDataTable.mapRate = calibrationModeData.mapRate
        calibrationModeDataTable.thresholdRise = calibrationModeData.thresholdRise
        calibrationModeDataTable.thresholdFall = calibrationModeData.thresholdFall
        calibrationModeDataTable.riseRate = calibrationModeData.riseRate
        calibrationModeDataTable.fallenRate = calibrationModeData.fallenRate
        
        do {
            try! realm.write {
                realm.add(calibrationModeDataTable)
                print("Realm.Add Success fileURL:\(realm.configuration.fileURL)")
            }
        } catch {
            print("Realm.Add Fail, Error:\(error.localizedDescription)")
        }
    }
    
// MARK: Update - Function
    
    func UpdateEvenData(eventData: EventDataTable, filter: String, rowValue: Int) {
        let realm = try! Realm()
        let deleteEventDataTable = realm.objects(EventData.self).filter(filter)
        try! realm.write{
            realm.delete(deleteEventDataTable[rowValue])
        }
        
        let addEventDataTable = EventData()
        addEventDataTable.id = eventData.id
        addEventDataTable.dateTime = eventData.dateTime
        addEventDataTable.displayTime = eventData.displayTime
        addEventDataTable.eventId = eventData.eventId
        addEventDataTable.eventValue = eventData.eventValue
        addEventDataTable.eventAttribute.removeAll()
        eventData.eventAttribute.forEach { attribute in
            addEventDataTable.eventAttribute.append(attribute)
        }
        addEventDataTable.note = eventData.note
        addEventDataTable.check = eventData.check
        
        try! realm.write {
            realm.add(addEventDataTable)
            print("Realm.Add Success fileURL:\(realm.configuration.fileURL)")
        }
    }
}

class Records: Object {
    @Persisted var count: Int = 0
    @Persisted var recordTime: String = "" // UTC+0
    @Persisted var displayTime: String = "" // UTC+8
    @Persisted var tempertaute: Int = 0
    @Persisted var adc1: Int = 0
    @Persisted var battery: Int = 0
    @Persisted var check: Bool = false
    @Persisted var calibrated: Bool = false
    
    convenience init(count: Int,
                     recordTime: String,
                     displayTime: String,
                     tempertaute: Int,
                     adc1: Int,
                     battery: Int,
                     check: Bool,
                     calibrated: Bool) {
        self.init()
        self.count = count
        self.recordTime = recordTime
        self.displayTime = displayTime
        self.tempertaute = tempertaute
        self.adc1 = adc1
        self.battery = battery
        self.check = check
        self.calibrated = calibrated
    }
}


class EventData: Object {
    @Persisted var id: Int = 0
    @Persisted var dateTime: String = ""  //UTC+0
    @Persisted var displayTime: String = "" //UTC+8
    @Persisted var eventAttribute: List<String>
    @Persisted var eventId: Int = 0
    @Persisted var eventValue: Int = 0
    @Persisted var note: String = ""
    @Persisted var check: Bool = false
    
    convenience init(id: Int,
                     dateTime: String,
                     displayTime: String,
                     eventAttribute: List<String>,
                     eventId: Int,
                     eventValue: Int,
                     note: String,
                     check: Bool) {
        self.init()
        self.id = id
        self.dateTime = dateTime
        self.displayTime = displayTime
        self.eventAttribute = eventAttribute
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
    @Persisted var gender: String = ""
    @Persisted var height: Int = 0
    @Persisted var weight: Int = 0
    @Persisted var race: String = ""
    @Persisted var liquor: String = ""
    @Persisted var smoke: Bool = false
    @Persisted var check: Bool = false
    @Persisted var phone_Verified: Bool = false
    
    convenience init(userId: String,
                     firstName: String,
                     lastName: String,
                     birthday: String,
                     email: String,
                     phone: String,
                     address: String,
                     gender: String,
                     height: Int,
                     weight: Int,
                     race: String,
                     liquor: String,
                     smoke: Bool,
                     check: Bool,
                     phone_Verified: Bool) {
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
