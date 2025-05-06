import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct GlassButton: View {
    var text: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        // Glass effect background
                        Color.white.opacity(0.15)
                            .cornerRadius(10)
                        // Overlay for a brighter highlight
                        Color.white.opacity(0.05)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1) // Optional border
                            )
                    }
                )
        }
        .padding(.horizontal, 40) // Adjust horizontal padding as needed
    }
}

struct WelcomeView: View {
    let heartGifURL = URL(string: "https://i.pinimg.com/originals/a4/a8/74/a4a874c79936fd1b5ed0e9faf2fef140.gif")! // Replace with your GIF URL
    @State private var isHomeScreenPresented = false

    var body: some View {
        NavigationView { // Still need NavigationView as an ancestor for fullScreenCover on iOS < 16
            ZStack {
                // Gradient from the image (adjust colors as needed)
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.3), Color(red: 0.9, green: 0.1, blue: 0.3)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack() {
                    VStack(spacing: 10) {
                        NavigationLink(destination: HomeViewMatch()){
                            Text("Finally, \nNo More Swiping!") // Text from the image
                                .font(.system(size: 62, weight: .bold, design: .default)) // Adjusted font to be closer to the image
                                .foregroundColor(.white) // White text for better contrast on the gradient
                                .multilineTextAlignment(.center)
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1) // Added a subtle shadow
                        }
                    }
                    NavigationLink(destination: HomeView()){
                        WebView(url: heartGifURL)
                            .frame(width: 250, height: 250) // Adjust size as needed.  Increased size to match image
                    }
                    Spacer()
                }

                .padding(.vertical, 80)
                VStack { // New VStack to hold the button at the bottom
                    Spacer() // Push the content below it to the bottom
                    GlassButton(text: "Get Started") {
                        isHomeScreenPresented = true // Set the state to present Home Screen
                    }
                    .padding(.bottom, 50) // Add some bottom padding for visual spacing
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .fullScreenCover(isPresented: $isHomeScreenPresented) {
                CreateAccountView() // Present your HomeScreen here
            }
        }
        .navigationViewStyle(.stack) // Ensures correct fullScreenCover behavior
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
