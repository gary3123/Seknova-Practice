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
    }
    
    var email: String {
        get { return userPreferance.string( forKey: UserPreference.email.rawValue) ?? ""}
        set { return userPreferance.set( newValue, forKey: UserPreference.email.rawValue)}
    }
    var password: String {
        get { return userPreferance.string( forKey: UserPreference.password.rawValue) ?? ""}
        set { return userPreferance.set( newValue, forKey: UserPreference.password.rawValue)}
    }
}
