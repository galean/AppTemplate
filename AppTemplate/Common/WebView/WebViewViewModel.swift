//
//  WebViewViewModel.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import Foundation

extension WebViewViewModel {
    class WebViewModel {
        let url: URL
        let title: String
        
        init(url: URL, title: String) {
            self.url = url
            self.title = title
        }
        
        static var terms: WebViewModel {
            return WebViewModel(
                url: .init(string: "https://tou.homeworkaihelper.com/")!,
                title: "terms"
            )
        }
        
        static var privacy: WebViewModel {
            return WebViewModel(
                url: .init(string: "https://pp.homeworkaihelper.com/")!,
                title: "privacy"
            )
        }
    }
}

class WebViewViewModel: ObservableObject {
    @Published private(set) var showLoader: Bool = false
    
    //MARK: - Properties
    weak var coordinator: WebViewCoordinatorDelegate?
    var source: WebViewModel
    
    //MARK: - Init
    init(source: WebViewModel) {
        self.source = source
    }
    
    deinit {
        debugPrint("DEINIT \(self)")
    }
    
    func onAppear() {
        showLoader = true
    }
    
    func hideLoader() {
        showLoader = false
    }
     
    func closeView() {
        coordinator?.dismiss()
    }
}
