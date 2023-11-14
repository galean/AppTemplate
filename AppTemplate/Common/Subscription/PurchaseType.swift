//
//  SubscriptionType.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 16.06.2023.
//

import Foundation

public enum PurchaseType: Int {
    case unknown = -2,
    custom,
    lifetime,
    annual,
    sixMonth,
    threeMonth,
    twoMonth,
    monthly,
    weekly
}
