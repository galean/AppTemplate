import SwiftUI

struct OnboardingView_1: View {
    
    @EnvironmentObject var coordinator: BaseCoordinator
    
    var body: some View {
        VStack {
            Spacer()
            Text("Onboarding View 1")
            Spacer()
            Button("Show Next Step") {
                coordinator.push(.onboarding2)
            }
        }
        .toolbar(.hidden)
    }
}

#Preview {
    OnboardingView_1()
}

