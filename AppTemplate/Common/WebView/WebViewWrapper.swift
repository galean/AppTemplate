//
//  WebViewWrapper.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import SwiftUI
import WebKit

struct WebViewWrapper: UIViewRepresentable {
    let url: URL
    var didLoad: EmptyBlock?
    
    func makeUIView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        wkwebView.navigationDelegate = context.coordinator
        wkwebView.load(URLRequest(url: url))
        return wkwebView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(didLoad: didLoad)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var didLoad: EmptyBlock?
        
        init(didLoad: EmptyBlock?) {
            self.didLoad = didLoad
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            didLoad?()
        }
    }
}
