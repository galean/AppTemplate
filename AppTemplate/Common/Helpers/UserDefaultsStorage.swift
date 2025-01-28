//
//  UDManager.swift
//  AppTemplate
//
//  Created by Anzhy on 28.01.2025.
//

import Foundation

class UserDefaultsStorage {
    static var shared = UserDefaultsStorage()
    
    private enum Keys: String {
        case onboardingPassed
    }
    
    var onboardingPassed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.onboardingPassed.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.onboardingPassed.rawValue)
        }
    }
}
