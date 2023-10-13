//
//  SubscriptionPriceManager.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 16.06.2023.
//

//import SwiftyStoreKit
//
//class SubscriptionPriceManager {
//    static let shared = SubscriptionPriceManager()
//
//    private init() { }
//
//    private var prices: [String: String] = {
//        SubscriptionType.allCases.reduce(into: [String: String]()) { partialResult, subType in
//            partialResult[subType.identifier] = subType.defaultPrice
//        }
//    }()
//
//    func changePrice(for subscription: String, price: String) {
//        prices[subscription] = price
//    }
//
//    func getPrice(for subscription: String) -> String? {
//        return prices[subscription]
//    }
//
//    func updatePrices() {
//        let allSubscription = Set(SubscriptionType.allCases.map { $0.rawValue })
//
//        SwiftyStoreKit.retrieveProductsInfo(allSubscription) { [weak self] result in
//            let products = result.retrievedProducts
//            products.forEach { product in
//                guard let price = product.localizedPrice else { return }
//                self?.changePrice(
//                    for: product.productIdentifier,
//                    price: price
//                )
//            }
//        }
//    }
//
//}

