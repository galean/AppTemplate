//
//  LaunchView.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//  Copyright (c) 2024. All rights reserved.
//

import SwiftUI

struct LaunchView: View {
    @StateObject var viewModel: LaunchViewModel
    
    var body: some View {
        buildContent()
    }
    
    @ViewBuilder
    private func buildContent() -> some  View {

    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(
            viewModel: LaunchViewModel(container: AppEnvironment.bootstrap().container)
        )
    }
}
