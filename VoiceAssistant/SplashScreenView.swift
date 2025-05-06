import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var opacity = 1.0
    @State private var isLoggedIn = false

    var body: some View {
        if isActive {
            if isLoggedIn {
                // AIChatView() // Replace with your actual HomeView
                Text("Home Screen") // Placeholder
            } else {
 //               HomeView() // Replace with your actual WelcomeView
                WelcomeView()
//                CreateAccountView()
            }
        } else {
            VStack {
                Image("Heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)

                Text("Soul")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.primary)
            }
            .opacity(opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Adjust the total duration as needed
                    withAnimation(.easeOut(duration: 1.0)) { // Adjust the fade-out duration
                        self.opacity = 0.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Small delay after fade-out before switching
                        self.isActive = true
                    }
                }
                // Authentication check (moved here for clarity)
                // if Auth.auth().currentUser != nil {
                //     self.isLoggedIn = true
                // }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
