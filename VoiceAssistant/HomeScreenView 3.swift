import SwiftUI

struct HomeViewOptions: View {
    @State private var selectedTab = 0 // 0 for Around You, 1 for Top Picks, 2 for Matchmaker Pick
    @State private var connectionHistory: [Connection] = [
        Connection(name: "Emily", startDate: "Feb 14, 2023", endDate: "Mar 20, 2023"),
        Connection(name: "Jessica", startDate: "Jan 05, 2023", endDate: "Feb 10, 2023")
        // Add more connections as needed
    ]

    var body: some View {
        NavigationView {
            ZStack{ LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.3), Color(red: 0.9, green: 0.1, blue: 0.3)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    // Custom Tab Bar
                    HStack {
                        tabButton(text: "Connection", isSelected: selectedTab == 0) {
                            selectedTab = 0
                        }
                        tabButton(text: "Soul AI", isSelected: selectedTab == 1) {
                            selectedTab = 1
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    
                    // Tab Content
                    TabView(selection: $selectedTab) {
                        aroundYouView // Extract tab content to functions
                            .tag(0)
                        matchmakerPickView
                            .tag(1)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never)) // Hide default tab indicator
                    .background(Color.white)
                    
                }
               // Hide the default navigation bar
                //            .background(
                //                LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.3), Color(red: 0.9, green: 0.1, blue: 0.3)]), startPoint: .top, endPoint: .bottom)
                //                    .edgesIgnoringSafeArea(.all)
                //            )
            }
        } .navigationBarHidden(true)
    }

    // MARK: - Tab Button Component
    private func tabButton(text: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack {
                Text(text)
                    .font(.system(size: 20, weight: isSelected ? .semibold : .medium)) // Bold for selected
                    .foregroundColor(isSelected ? .primary : .gray) // Use primary color for selected
                if isSelected {
                    Rectangle()
                        .frame(height: 3) // Underline for selected tab
                        .foregroundColor( .accentColor) // Use accent color
                        .animation(.easeInOut, value: selectedTab) // Smooth transition
                } else {
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(.clear)
                }
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity) // Make buttons equally wide
        }
    }

    // MARK: - Tab Content Views
    private var aroundYouView: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer()
//                let searchGifURL = URL(string: "https://media.baamboozle.com/uploads/images/81301/1629899676_260842_gif-url.gif")!
//                WebView(url: searchGifURL)
//                    .frame(width: 250, height: 250)
//                Text("Looking for Matches")
//                    .font(.headline)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .padding(.top)

                // SCENARIO 3: Looking for Matches
//                Spacer()
//                VStack(spacing: 10) {
////                    Image(systemName: "magnifyingglass")
////                        .font(.largeTitle)
////                        .foregroundColor(.gray)
//                    Text("Soul is looking for your potential matches")
//                        .font(.largeTitle)
//                        .multilineTextAlignment(.center)
//                        .foregroundColor(.black)
//                    Text("Congratulations, you've joined the community")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                        .multilineTextAlignment(.center)
//                    Text("We will notify you soon!")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                        .multilineTextAlignment(.center)
//                }
//                .padding()
//                Spacer()
                
                Text("Souls Picked for you!")  //moved title here
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)

                // SCENARIO 1: Potential Matches
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                        PotentialMatchCard(name: "Ana Karina", isOnline: true, lastMessage: "96%")
                        PotentialMatchCard(name: "Christine", isOnline: false, lastMessage: "91%")
                        PotentialMatchCard(name: "Jasmin", isOnline: false, lastMessage: "89%")
                        // Add more potential match cards here
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                }
                Spacer()
                
                Text("Skills & Insights")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.pink) // Use a color that closely matches
                // Grid of Features
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                FeatureButton(title: "First Date Masterclass", icon: "calendar.badge.plus") // More mature icon
                                FeatureButton(title: "Your Love Life Insights", icon: "heart.text.square")  // More mature icon
                                FeatureButton(title: "Become Ideal Partner", icon: "person.2.fill")    // More mature icon
                                FeatureButton(title: "Guide to Relationships", icon: "suit.heart.fill") //simplified chinese
                                FeatureButton(title: "Craft an Ideal Profile", icon: "person.text.rectangle")  // More mature icon
                                FeatureButton(title: "How to Avoid Redflags", icon: "flag.slash.circle")    // More mature icon
                            }
                .padding(.horizontal)
                .padding(.bottom)

               
//                
//                Text("Active Match")
//                    .font(.headline)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal)
//
//                // SCENARIO 2: Active Match
//                ActiveMatchCard(name: "Sarah", isOnline: true, lastMessage: "5m ago", connectedDays: 32, longestStreak: 450, compatibilityProgress: 91)
//                    .padding(.horizontal)
//                    .padding(.bottom)
//
//               

                
            }
            .padding(.bottom, 40)
        }
    }

    private var topPicksView: some View {
        // Content for Top Picks tab
        Text("Top Picks Content")
            .font(.title)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var matchmakerPickView: some View{
        VStack{
            let heartGifURL = URL(string: "https://i.pinimg.com/originals/a4/a8/74/a4a874c79936fd1b5ed0e9faf2fef140.gif")!
            WebView(url: heartGifURL)
                .frame(width: 250, height: 250)

            Text("Your Privacy is our Priority")
//                .font(.title3)
                .font(.system(size: 32, weight: .bold, design: .default))
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.black)

            Text("Discuss anything and everything about your life with Soul AI")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: {
                // Handle the action
            }){
               
                    VStack(spacing: 10) {
                        Spacer()
                        HStack(spacing: 16) {
                                        Button(action: {
                                            // Handle message action
                                        }) {
                                            NavigationLink(destination: AIChatView()) {
                                                HStack {
                                                    Image(systemName: "message.fill") // Message icon
                                                        .foregroundColor(.white)
                                                    Text("Chat")
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .padding(.horizontal, 24)
                                            .padding(.vertical, 12)
                                            .background(Color(red: 0.1, green: 0.1, blue: 0.3))
                                            .cornerRadius(10)
                                        }

                                        Button(action: {
                                            // Handle call action
                                        }) {
                                            NavigationLink(destination: ContentView()) {
                                                HStack {
                                                    Image(systemName: "phone.fill") // Call icon
                                                        .foregroundColor(.white)
                                                    Text("Call")
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .padding(.horizontal, 24)
                                            .padding(.vertical, 12)
                                            .background(Color(red: 0.1, green: 0.1, blue: 0.3))
                                            .cornerRadius(10)
                                        }
                                    }
                                    .padding(.horizontal)
                                    .padding(.bottom)
                    
                }
            }
            Spacer()
            Text("Video calls for the Deaf and hard of hearing community are coming soon.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }

    // Helper functions to calculate connection stats
    func totalDaysConnected() -> Int {
        // Calculate the total number of days connected from connectionHistory
        // ... (Implementation to calculate total days)
        return 169 // Placeholder
    }

    func longestConnection() -> Int {
        // Calculate the longest connection duration from connectionHistory
        // ... (Implementation to calculate longest connection)
        return 420 // Placeholder
    }
}
