import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var coordinator: BaseCoordinator
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    coordinator.fullScreen(.paywall(source: .main))
                }) {
                    Text("Paywall")
                }
                Spacer()
                Button(action: {
                    coordinator.push(.settings)
                }) {
                    Text("Settings")
                }
            }
            Spacer()
            Text("Content View")
                .font(.system(size: 32, weight: .heavy))
            Spacer()
            Button(action: {
                coordinator.popTo(.onboarding1)
            }) {
                Text("Open Onboarding")
            }
        }
        .padding(.horizontal, 16)
        .background(Color.white)
        .toolbar(.hidden)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
