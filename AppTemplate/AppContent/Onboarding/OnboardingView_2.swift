import SwiftUI

struct OnboardingView_2: View {
    
    @EnvironmentObject var coordinator: BaseCoordinator
    
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
