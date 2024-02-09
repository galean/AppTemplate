//
//  AppEnvironment.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import Foundation

struct AppEnvironment {
    let container: DIContainer
    
    static func bootstrap() -> AppEnvironment {
        let container = configuredServices()
        return AppEnvironment(container: container)
    }
    
    private static func configuredServices() -> DIContainer {
        return DIContainer()
    }
}
