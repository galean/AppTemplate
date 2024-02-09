//
//  EmptyPaywallViewModel.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//  Copyright (c) 2024. All rights reserved.
//

import Foundation

class EmptyPaywallViewModel: ObservableObject {
    //MARK: - Observed properties
    @Published private(set) var showLoader: Bool = false
    @Published private(set) var alert: AlertViewModel = .init()
    @Published var showAlert: Bool = false
    
    //MARK: - Properties
    weak var coordinator: PaywallCoordinatorDelegate?
    
    //MARK: - Private properties
    
    
    //MARK: - AlertType
    enum EmptyPaywallAlertType {
        case other(message: String)
        
        var message: String {
            switch self {
            case let .other(message): return message
            }
        }
    }
    
    //MARK: - Init
    init() {
        
    }
    
    deinit {
        debugPrint("DEINIT \(self)")
    }
    
    //MARK: - Inpunt
    func onAppear() { }
    
    func onDisappear() { }
    
    //MARK: - Alerts
    private func alertHandler(_ alerts: [EmptyPaywallAlertType]) {
        alerts.forEach {
            switch $0 {
            case let .other(message):
                alert = AlertViewModel(title: message)
            }
        }
        showAlert = true
    }
}
