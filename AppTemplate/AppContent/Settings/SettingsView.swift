
import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var coordinator: BaseCoordinator
    
    var body: some View {
        VStack {
            HStack {
                Button("Close") {
                    coordinator.pop()
                }
                Spacer()
                Button("Premium") {
                    coordinator.fullScreen(.paywall(source: .settings))
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
