
import SwiftUI

struct SplashView: View {
    @EnvironmentObject var coordinator: BaseCoordinator

    var body: some View {
        buildContent()
    }
    
    func buildContent() -> some View {
        Text("Splash View")
            .font(.system(size: 30, weight: .bold))
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .background(.gray)
            .toolbar(.hidden)
    }
}

#Preview {
    SplashView()
}
