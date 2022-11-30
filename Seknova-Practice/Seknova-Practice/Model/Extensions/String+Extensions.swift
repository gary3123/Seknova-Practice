//
//  String+Extensions.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/11/3.
//

import Foundation

extension String {
    
    enum Validate {
        case email
        case password
        case phone
        case deviceID
    }
    
    func validate(type: Validate) -> Bool {
        var predicateRule: String!
        
        switch type {
        case .email:
            predicateRule = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}"
        case .password:
            predicateRule = "^(?=.*[a-z])(?=.*\\d)[a-zA-Z\\d]{8,16}$"
        case .phone:
            predicateRule = "[0-9]{9,10}"
        case .deviceID:
            predicateRule = "[0-9A-F]{6}"
        }
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", predicateRule)
        return predicate.evaluate(with: self)
    }
    
    
}
