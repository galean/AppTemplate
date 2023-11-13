//
//  Subscription.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 13/11/23.
//

import Foundation
import RevenueCat

public struct Subscription: Hashable {
    public let isSubscription: Bool
    public let package: Package
    public let price: CGFloat
    public let periodString: String
    public let trialPrice: CGFloat?
    public let trialPeriodstring: String
    public let trialCount: Int
    public let currencyCode: String
    public let localisedPrice: String
    public let localisedTrialPrice: String?
    public let type: SubscriptionType
    
    public init(isSubscription: Bool, package: Package, price: CGFloat, periodString: String, trialPrice: CGFloat?, trialPeriodstring: String, trialCount: Int, currencyCode: String, localisedPrice: String, localisedTrialPrice: String?, type: SubscriptionType) {
        self.isSubscription = isSubscription
        self.package = package
        self.price = price
        self.periodString = periodString
        self.trialPrice = trialPrice
        self.trialPeriodstring = trialPeriodstring
        self.trialCount = trialCount
        self.currencyCode = currencyCode
        self.localisedPrice = localisedPrice
        self.localisedTrialPrice = localisedTrialPrice
        self.type = type

    }
}

extension StoreProduct {
    var priceFloat: CGFloat {
        CGFloat(NSDecimalNumber(decimal: price).floatValue)
    }
    
    var introPrice: CGFloat? {
        guard let intro = introductoryDiscount else {
            return nil
        }
        
        return CGFloat(NSDecimalNumber(decimal: intro.price).floatValue)
    }
    
    var periodString: String {
        let count = subscriptionPeriod?.value ?? 0
        switch subscriptionPeriod?.unit {
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
        switch introductoryDiscount?.subscriptionPeriod.unit {
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
    
    var trialCount: Int {
        return introductoryDiscount?.subscriptionPeriod.value ?? 0
    }
}
