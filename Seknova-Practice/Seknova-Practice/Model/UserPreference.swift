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
}
