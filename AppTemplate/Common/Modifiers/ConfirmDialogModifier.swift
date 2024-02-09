//
//  ConfirmDialogModifier.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import SwiftUI

struct ConfirmDialogModifier: ViewModifier {
    let viewModel: AlertViewModel
    
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .confirmationDialog(viewModel.title ?? "", isPresented: $isPresented) {
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
                    case .destructive:
                        Button(button.title, role: .cancel) {
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
