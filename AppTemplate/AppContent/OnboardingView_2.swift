//
//  OnboardingView_2.swift
//  NavDemo
//
//  Created by Anatolii Kanarskyi on 13.01.2025.
//
import SwiftUI

struct OnboardingView_2: View {
    
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
            Text("Onboarding View 2")
            Spacer()
            Button("Show Next Step") {
                coordinator.push(.onboarding3)
            }
        }
        .padding(.horizontal, 16)
        .toolbar(.hidden)
    }
}

#Preview {
    OnboardingView_2()
}
