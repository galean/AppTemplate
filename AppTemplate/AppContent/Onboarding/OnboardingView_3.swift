import SwiftUI

struct OnboardingView_3: View {
    
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
            Text("Onboarding View 3")
            Spacer()
            Button("Show Paywall") {
                coordinator.fullScreen(.paywall(source: .onboarding))
//                coordinator.push(.paywall)
            }
        }
        .padding(.horizontal, 16)
        .toolbar(.hidden)
    }
}

#Preview {
    OnboardingView_3()
}
