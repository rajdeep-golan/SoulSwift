import SwiftUI

@main
struct VoiceAssistantApp: App {
    private var tokenService: TokenService = .init()

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
//            ContentView()
              .environmentObject(tokenService)
        }
    }
}
