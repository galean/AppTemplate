//
//  PaywallDataSource.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 15/11/23.
//

import Foundation
import CoreIntegrations

struct PaywallDataSource: CorePaywallDataSource {
    typealias PaywallInitialConfiguration = PaywallConfig
    typealias PurchaseGroup = AppPurchaseGroup
}
