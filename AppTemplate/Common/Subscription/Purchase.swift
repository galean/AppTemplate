//
//  Subscription.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 13/11/23.
//

import Foundation
import RevenueCat

public struct Purchase: Hashable {
    public let package: Package
    
    public init(package: Package) {
        self.package = package
    }
    
    var storeProduct: StoreProduct {
        return package.storeProduct
    }
    
    var isSubscription: Bool {
        let isSubscription = package.storeProduct.productType == .autoRenewableSubscription || package.storeProduct.productType == .nonRenewableSubscription
        return isSubscription
    }
    
    var purchaseType:PurchaseType {
        return PurchaseType(rawValue: package.packageType.rawValue) ?? .unknown
    }
    
    var identifier:String {
        return package.storeProduct.productIdentifier
    }
    
    var localisedPrice: String {
        return package.localizedPriceString
    }
    
    var localizedIntroductoryPriceString: String? {
        return package.localizedIntroductoryPriceString
    }
    
    var priceFloat: CGFloat {
        CGFloat(NSDecimalNumber(decimal: package.storeProduct.price).floatValue)
    }
    
    var periodString: String {
        let count = package.storeProduct.subscriptionPeriod?.value ?? 0
        switch package.storeProduct.subscriptionPeriod?.unit {
        case .day:
            return "day"
        case .week:
            return "week"
        case .month:
            if count == 3 {
                return "quarter"
            }
            return "month"
        case .year:
            return "year"
        case nil:
            return ""
        }
    }
    
    var trialPeriodString: String {
        switch package.storeProduct.introductoryDiscount?.subscriptionPeriod.unit {
        case .day:
            return "day"
        case .week:
            return "week"
        case .month:
            return "month"
        case .year:
            return "year"
        case nil:
            return ""
        }
    }
    
    var periodCount: Int {
        return package.storeProduct.subscriptionPeriod?.value ?? 0
    }
    
    var trialCount: Int {
        return package.storeProduct.introductoryDiscount?.subscriptionPeriod.value ?? 0
    }
}
