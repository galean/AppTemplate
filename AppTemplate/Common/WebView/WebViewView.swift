//
//  WebViewView.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import SwiftUI

struct WebViewView: View {
    @StateObject var viewModel: WebViewViewModel
    
    var body: some View {
        buildContent()
            .onAppear(perform: viewModel.onAppear)
            .showLoader(viewModel.showLoader)
    }
    
    @ViewBuilder
    private func buildContent() -> some  View {
        WebViewWrapper(
            url: viewModel.source.url,
            didLoad: viewModel.hideLoader
        )
        .ignoresSafeArea()
        .navigationTitle(viewModel.source.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.closeView()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.red)
            }
            .padding(.trailing, 5)
        }
    }
}

struct WebViewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WebViewView(
                viewModel: WebViewViewModel(source: .privacy)
            )
        }
    }
}
