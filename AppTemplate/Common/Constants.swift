//
//  Constants.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import UIKit

typealias EmptyBlock    = () -> Void
typealias Block<T>      = (T) -> Void
typealias ResultBlock   = (_ success: Bool, _ error: String?) -> Void
typealias ResultEnumBlock<T, E: Error> = (Result<T, E>) -> Void
typealias TupleBlock<T, K> = (T, K) -> Void
typealias ResendTimerBlock = (String, Bool) -> Void
typealias CompletionBlock<T> = Block<Block<T>>

let baseAppRefreshAnimation: TimeInterval = 0.3
let screenHeight: CGFloat = UIScreen.main.bounds.height
let screenWidth: CGFloat = UIScreen.main.bounds.width
let smallDevice: Bool = screenHeight == 667

// App environment
struct ProjectEnvironmentConstants {
    enum Env {
        case development
        case production
    }
    
    static var current: Env = .development
    static var deviceID: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
    static func baseUrl(_ env: Env = current) -> String {
        var components = URLComponents()
        components.scheme = BaseURL.scheme
        components.host = BaseURL.host(env)
        return (components.string ?? "") + "/"
    }
}

extension ProjectEnvironmentConstants {
    struct BaseURL {
        static let scheme = "https"
        static let rootPath = "/api"
        static func host(_ env: Env = current) -> String {
            switch env {
            case .development:  return ""
            case .production:   return ""
            }
        }
    }
}
