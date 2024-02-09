//
//  AlertViewModel.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import SwiftUI

struct AlertViewModel {
    struct Button: Identifiable {
        enum ButtonType {
            case regular
            case cancel
            case destructive(_ title: String = "Cancel")
            case title(_ title: String)
            
            var title: String {
                switch self {
                case .regular: return "OK"
                case .cancel: return "Cancel"
                case let .destructive(title): return title
                case let .title(title): return title
                }
            }
        }
        
        var id: String = UUID().uuidString
        var title: String { return type.title }
        var type: ButtonType = .regular
        var action: (() -> Void)?
    }
    
    var title: String? = nil
    var message: String? = nil
    var buttons: [Button] = [Button(type: .regular)]
}

struct AlertModifier: ViewModifier {
    let viewModel: AlertViewModel
    
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .alert(viewModel.title ?? "", isPresented: $isPresented) {
                ForEach(viewModel.buttons, id:\.id) { button in
                    switch button.type {
                    case .regular:
                        Button(button.title) {
                            button.action?()
                        }
                    case .cancel:
                        Button(button.title, role: .cancel) {
                            button.action?()
                        }
                    case .destructive(let title):
                        Button(title, role: .destructive) {
                            button.action?()
                        }
                    case .title(let title):
                        Button(title) {
                            button.action?()
                        }
                    }
                }
            } message: {
                if viewModel.message != nil {
                    Text(viewModel.message ?? "")
                }
            }
    }
}
