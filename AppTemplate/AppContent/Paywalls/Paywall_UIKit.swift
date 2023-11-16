//
//  Paywall_UIKit.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import UIKit
import SwiftUI
import CoreIntegrations

class Paywall_UIKit: UIViewController, PaywallViewProtocol {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Hello, Paywall_UIKit"
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var subscribeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Subscribe", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(subscribeAction), for: .touchUpInside)
        return button
    }()
        
    var purchases: [Purchase] = []
    
    let paywallConfig: PaywallConfig = .ct_vap_3
    var closeResult: PaywallResultClosure? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        paywallConfig.purchases { result in
            switch result {
            case .success(let purchases):
                self.purchases = purchases
            case .error(let error):
                print("paywallConfig.purchases error \(error)")
            }
            
        }
        
    }
    
    private func setupViews() {
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(subscribeButton)
        
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        subscribeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        subscribeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        subscribeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        subscribeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
       /*
        for purchase in self.purchases {
            "\(purchase.localisedPrice)/\(purchase.periodString)"
        }
        */
        
    }
    
    @objc private func closeAction() {
        dismiss(animated: true)
        closeResult?(.close)
    }
    
    @objc private func subscribeAction() {
        dismiss(animated: true)
        closeResult?(.purchase)
    }
    
    private func purchase(_ purchase: Purchase) {
        CoreManager.shared.purchase(purchase) { result in
            
        }
    }
    
    private func restore() {
        CoreManager.shared.restorePremium { result in
            
        }
    }
}

struct Paywall_UIKitRepresentable: UIViewControllerRepresentable {
    
    var closeResult: PaywallResultClosure? = nil
    
    func makeUIViewController(context: Context) -> Paywall_UIKit {
        let ct_vap_3 = Paywall_UIKit()
        ct_vap_3.closeResult = closeResult
        return ct_vap_3
    }
    
    func updateUIViewController(_ uiViewController: Paywall_UIKit, context: Context) {

    }
}
