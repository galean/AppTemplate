//
//  LaunchView.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 16.06.2023.
//

import SwiftUI

class LaunchViewModel: ObservableObject {
    @Published var showNextScreen: Bool = false
    
    func handleOnAppear() {
        AppCoreManager.shared.configurationFinishCompletion = {
            DispatchQueue.main.async {
                self.showNextScreen = true
            }
        }
    }
}

struct LaunchView: View {
    @StateObject var vm = LaunchViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Launch screen")
        }
        .padding()
        .onAppear {
            vm.handleOnAppear()
        }
        .fullScreenCover(isPresented: $vm.showNextScreen) {
            ContentView()
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
