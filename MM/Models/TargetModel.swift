//
//  TargetModel.swift
//  MM
//
//  Created by Даниил Мухсинятов on 01.01.2023.
//

import Foundation

final class TargetModel {
    
    private enum Constants {
        static let key = "targetValue"
    }
    
    static func removeTargetValue() {
        UserDefaults.standard.removeObject(forKey: Constants.key)
    }
    
    static var targetValue: Double! {
        get {
            return UserDefaults.standard.double(forKey: Constants.key)
        }
        set {
            let defaults = UserDefaults.standard
            if let value = newValue {
                print("Sistem: \"value: \(value) was added to key \(Constants.key)\"")
                defaults.set(value, forKey: Constants.key)
            } else {
                defaults.removeObject(forKey: Constants.key)
            }
        }
    }
}
