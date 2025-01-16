
import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var coordinator: DefaultNavigationCoordinator
    
    var body: some View {
        VStack {
            HStack {
                Button("Close") {
                    coordinator.pop()
                }
                Spacer()
                Button("Premium") {
                    coordinator.fullScreen(.paywall)
                }
            }
            Spacer()
            Text("Settings View")
            Spacer()
        }
        .padding(.horizontal, 16)
        .toolbar(.hidden)
    }
    
}

#Preview {
    SettingsView()
}
