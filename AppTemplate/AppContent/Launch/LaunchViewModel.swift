//
//  LaunchViewModel.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//  Copyright (c) 2024. All rights reserved.
//

import Foundation

class LaunchViewModel: ObservableObject {
    //MARK: - Properties
    var configurationEnd: EmptyBlock?
    
    //MARK: - Private properties
    
    //MARK: - Init
    init(container: DIContainer) {

    }
    
    deinit {
        debugPrint("DEINIT \(self)")
    }
}
