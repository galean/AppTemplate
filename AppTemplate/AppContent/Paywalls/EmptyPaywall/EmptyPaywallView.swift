//
//  EmptyPaywallView.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//  Copyright (c) 2024. All rights reserved.
//

import SwiftUI

struct EmptyPaywallView: View {
    @StateObject var viewModel: EmptyPaywallViewModel
    
    var body: some View {
        buildContent()
            .onAppear(perform: viewModel.onAppear)
            .onDisappear(perform: viewModel.onDisappear)
            .showLoader(viewModel.showLoader)
            .showAlert(viewModel: viewModel.alert, isPresented: $viewModel.showAlert)
    }
    
    @ViewBuilder
    private func buildContent() -> some  View {

    }
}

struct EmptyPaywallView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPaywallView(
            viewModel: EmptyPaywallViewModel()
        )
    }
}
