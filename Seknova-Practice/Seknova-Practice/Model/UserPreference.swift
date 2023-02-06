//
//  UserPreference.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/21.
//

import Foundation

class UserPreferences {
    static let shared = UserPreferences()
    private let userPreferance: UserDefaults
    private init() {
        userPreferance = UserDefaults.standard
    }
    
    enum UserPreference: String {
        case email
        case password
        case firstLogin
        case lowBloodSugar
        case highBloodSugar
        case deviceID
        case sensorID
        case ADCInitialValue
        case xAxisTimeInterval
        case yUpperLimit
        case yLowerLimit
        case unitSwitching
        case showNumericalInformation
        case showRSSI
        case uploadCloud
        case bloodSugarWarning
        case warmUpStatus
        case highAlerts
        case lowAlerts
        case rateAlerts
        case alertAudio
        case SettingDevelopStatus
    }
    
    var email: String {
        get { return userPreferance.string( forKey: UserPreference.email.rawValue) ?? ""}
        set { return userPreferance.set( newValue, forKey: UserPreference.email.rawValue)}
    }
    var password: String {
        get { return userPreferance.string( forKey: UserPreference.password.rawValue) ?? ""}
        set { return userPreferance.set( newValue, forKey: UserPreference.password.rawValue)}
    }
    
    var firstLogin: Bool {
        get {return userPreferance.bool(forKey: UserPreference.firstLogin.rawValue) }
        set {return userPreferance.set( newValue, forKey: UserPreference.firstLogin.rawValue)}
    }
    
    var lowBloodSugar: Int {
        get {return userPreferance.integer(forKey: UserPreference.lowBloodSugar.rawValue) }
        set {return userPreferance.set( newValue, forKey: UserPreference.lowBloodSugar.rawValue)}
    }
    
    var highBloodSugar: Int {
        get {return userPreferance.integer(forKey: UserPreference.highBloodSugar.rawValue) }
        set {return userPreferance.set( newValue, forKey: UserPreference.highBloodSugar.rawValue)}
    }
    var deviceID: String {
        get { return userPreferance.string( forKey: UserPreference.deviceID.rawValue) ?? ""}
        set { return userPreferance.set( newValue, forKey: UserPreference.deviceID.rawValue)}
    }
    var sensorID: String {
        get { return userPreferance.string( forKey: UserPreference.sensorID.rawValue) ?? ""}
        set { return userPreferance.set( newValue, forKey: UserPreference.sensorID.rawValue)}
    }
    
    var ADCInitialValue: Int {
        get { return userPreferance.integer( forKey: UserPreference.ADCInitialValue.rawValue)}
        set { return userPreferance.set( newValue, forKey: UserPreference.ADCInitialValue.rawValue)}
    }
    
    var xAxisTimeInterval: Double {
        get { return userPreferance.double( forKey: UserPreference.xAxisTimeInterval.rawValue) }
        set { return userPreferance.set( newValue, forKey: UserPreference.xAxisTimeInterval.rawValue)}
    }
    
    var yAxisUpperLimit: Int {
        get { return userPreferance.integer( forKey: UserPreference.yUpperLimit.rawValue) }
        set { return userPreferance.set( newValue, forKey: UserPreference.yUpperLimit.rawValue)}
    }
    
    var yAxisLowerLimit: Int {
        get { return userPreferance.integer( forKey: UserPreference.yLowerLimit.rawValue) }
        set { return userPreferance.set( newValue, forKey: UserPreference.yLowerLimit.rawValue)}
    }
    
    var unitSwitching: Bool {
        get {return userPreferance.bool(forKey: UserPreference.unitSwitching.rawValue) }
        set {return userPreferance.set( newValue, forKey: UserPreference.unitSwitching.rawValue)}
    }
    
    var showNumericalInformation: Bool {
        get {return userPreferance.bool(forKey: UserPreference.showNumericalInformation.rawValue) }
        set {return userPreferance.set( newValue, forKey: UserPreference.showNumericalInformation.rawValue)}
    }
    
    var showRSSI: Bool {
        get {return userPreferance.bool(forKey: UserPreference.showRSSI.rawValue) }
        set {return userPreferance.set( newValue, forKey: UserPreference.showRSSI.rawValue)}
    }
    
    var uploadCloud: Bool {
        get {return userPreferance.bool(forKey: UserPreference.uploadCloud.rawValue) }
        set {return userPreferance.set( newValue, forKey: UserPreference.uploadCloud.rawValue)}
    }
    
    var bloodSugarWarning: Bool {
        get {return userPreferance.bool(forKey: UserPreference.bloodSugarWarning.rawValue) }
        set {return userPreferance.set( newValue, forKey: UserPreference.bloodSugarWarning.rawValue)}
    }
    
    var warmUpStatus: Bool {
        get {return userPreferance.bool(forKey: UserPreference.warmUpStatus.rawValue) }
        set {return userPreferance.set( newValue, forKey: UserPreference.warmUpStatus.rawValue)}
    }
    
    var highAlert: String {
        get { return userPreferance.string( forKey: UserPreference.highAlerts.rawValue) ?? "none"}
        set { return userPreferance.set( newValue, forKey: UserPreference.highAlerts.rawValue)}
    }
    
    var lowAlerts: String {
        get { return userPreferance.string( forKey: UserPreference.lowAlerts.rawValue) ?? "none"}
        set { return userPreferance.set( newValue, forKey: UserPreference.lowAlerts.rawValue)}
    }
    
    var rateAlerts: String {
        get { return userPreferance.string( forKey: UserPreference.rateAlerts.rawValue) ?? "none"}
        set { return userPreferance.set( newValue, forKey: UserPreference.rateAlerts.rawValue)}
    }
    
    var alertAudio: String {
        get { return userPreferance.string( forKey: UserPreference.alertAudio.rawValue) ?? "none"}
        set { return userPreferance.set( newValue, forKey: UserPreference.alertAudio.rawValue)}
    }
    
    var SettingDevelopStatus: Bool {
        get {return userPreferance.bool(forKey: UserPreference.SettingDevelopStatus.rawValue) }
        set {return userPreferance.set( newValue, forKey: UserPreference.SettingDevelopStatus.rawValue)}
    }
    
}
