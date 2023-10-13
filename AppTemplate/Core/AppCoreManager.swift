//
//  CoreManager.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 03.10.2023.
//

import Foundation
import CoreIntegrations

class AppCoreManager {
    static var shared = AppCoreManager()
        
    var configurationFinished: Bool = false
    var configurationFinishCompletion: (() -> Void)? {
        didSet {
            if configurationFinished {
                configurationFinishCompletion?()
            }
        }
    }
}

extension AppCoreManager: CoreManagerDelegate {
    func coreConfigurationFinished(result: CoreManagerResult) {
        
        configurationFinished = true
        configurationFinishCompletion?()
    }
}
