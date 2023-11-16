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
    var configurationResult: CoreManagerResult?
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
        if result.userSource == .ipat {
            //set internal values for ipat
        }
        print("coreConfigurationFinished \(result)")
        configurationResult = result
        configurationFinished = true
        configurationFinishCompletion?()
    }
}
