//
//  SwiftUIView.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import SwiftUI

extension View {
    func makeViewController() -> UIViewController {
        UIHostingController(rootView: self)
    }
    
    @ViewBuilder
    func showLoader(_ show: Bool) -> some View {
        ZStack {
            self
            
            if show {
                ProgressView()
                    .tint(.blue)
                    .offset(y: -50)
            }
        }
    }
    
    @ViewBuilder
    func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
    
    func showAlert(viewModel: AlertViewModel, isPresented: Binding<Bool>) -> some View {
        ModifiedContent(content: self, modifier: AlertModifier(viewModel: viewModel, isPresented: isPresented))
    }
    
    func showConfirmDialog(viewModel: AlertViewModel, isPresented: Binding<Bool>) -> some View {
        ModifiedContent(content: self, modifier: ConfirmDialogModifier(viewModel: viewModel, isPresented: isPresented))
    }
}

