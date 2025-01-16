//
//  OnboardingView_3.swift
//  NavDemo
//
//  Created by Anatolii Kanarskyi on 13.01.2025.
//
import SwiftUI

struct OnboardingView_3: View {
    
    @EnvironmentObject var coordinator: DefaultNavigationCoordinator
    
    var body: some View {
        VStack {
            HStack {
                Button("Back") {
                    coordinator.pop()
                }
                Spacer()
            }
            Spacer()
            Text("Onboarding View 3")
            Spacer()
            Button("Show Paywall") {
                coordinator.push(.paywall)
            }
        }
        .padding(.horizontal, 16)
        .toolbar(.hidden)
    }
}

#Preview {
    OnboardingView_3()
}
