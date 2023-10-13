//
//  SubscriptionType.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 16.06.2023.
//

import Foundation

public protocol SubscriptionTypeProtocol {
    var identifier: String { get }
}

enum SubscriptionType: String, CaseIterable, SubscriptionTypeProtocol {
    case weekly10with3dTrial = "weekly.9.99.with.3d.trial"

    var identifier: String {
        self.rawValue
    }
    
    var defaultPrice: String {
        switch self {
        case .weekly10with3dTrial:
            return "9.99"
        }
    }
}
