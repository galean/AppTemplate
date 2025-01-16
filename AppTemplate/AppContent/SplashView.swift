
import SwiftUI

struct SplashView: View {
    
    var body: some View {
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
