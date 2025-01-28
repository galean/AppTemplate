//
//  PaywallState.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 16.06.2023.
//

import Foundation

enum PaywallState: Equatable {
    case waiting, purchasing, restoring
    case purchaseSuccess, purchaseError(message: String), purchaseCancelled
    case restoreSuccess, restoreError, nothingToRestore

    var isActiveState: Bool {
        return self == .purchasing || self == .restoring
    }

    var finishedState: Bool {
        return self == .purchaseSuccess || self == .restoreSuccess
    }

    var isActualError: Bool {
        switch self {
        case .purchaseError, .restoreError:
            return true
        default:
            return false
        }
    }
}
