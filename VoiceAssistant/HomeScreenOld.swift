//
//  HomeScreenView.swift
//  Soul
//
//  Created by Prakashdeep Golan on 3/11/25.
//
import SwiftUI

struct HomeViewA: View {
    @State private var showDrawer = false
    @State private var connectionHistory: [Connection] = [
        Connection(name: "Emily", startDate: "Feb 14, 2023", endDate: "Mar 20, 2023"),
        Connection(name: "Jessica", startDate: "Jan 05, 2023", endDate: "Feb 10, 2023")
        // Add more connections as needed
    ]
    var body: some View {
        ZStack(alignment: .topLeading) { // Use .topLeading for alignment
            ScrollView {
                VStack(spacing: 20) {
                    // SoulMate Header
                    HStack {
                        Spacer()
                        Text("Soul AI")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.top)

                    // Potential Matches (Amy, John, Lisa)
                    HStack {
                        NavigationLink(destination: SettingView()) {
                            VStack {
                                Image(systemName: "person.circle").foregroundColor(Color.black)
                                Text("Profile").foregroundColor(Color.black)
                            }
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "book.circle")
                            Text("Feed")
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "map.circle")
                            Text("Journey")
                        }
                    }
                    .padding(.horizontal)

                    // Active Conversation (Sarah)
                    VStack(spacing: 10) {
                        Text("Soul Connection")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            Image(systemName: "person.circle") // Placeholder for Sarah's image
                                .font(.system(size: 50))
                            VStack(alignment: .leading) {
                                Text("Sarah")
                                    .font(.title2)
                                Text("Last message: 2m ago")
                                    .font(.caption)
                            }
                            Spacer()
                            Text("Online")
                                .font(.caption)
                        }
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Total days connected: \(totalDaysConnected())")
                                    .font(.caption)
                                Text("Longest connection: \(longestConnection()) days")
                                    .font(.caption)
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    // AI Interaction Buttons
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 10),
                        GridItem(.flexible(), spacing: 10)
                    ], spacing: 10) {
                        Button(action: {
                            // Chat with AI action
                        }) {
                            NavigationLink(destination: AIChatView()) {
                                VStack(spacing: 10) {
                                    Image(systemName: "bubble.left.fill") // Icon for Chat
                                        .font(.system(size: 30))
                                    Text("Chat with Soul")
                                        .font(.headline)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                        }

                        Button(action: {
                            // Audio Call AI action
                        }) {
                            NavigationLink(destination: ContentView()) {
                                VStack(spacing: 10) {
                                    Image(systemName: "phone.fill") // Icon for Audio Call
                                        .font(.system(size: 30))
                                    Text("Audio Call Soul")
                                        .font(.headline)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                        }

                        Button(action: {
                            // Video Call AI action
                        }) {
                            VStack(spacing: 10) {
                                Image(systemName: "video.fill") // Icon for Video Call
                                    .font(.system(size: 30))
                                Text("Video Call Soul")
                                    .font(.headline)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }

                        Button(action: {
                            // Nearby Offers action
                        }) {
                            NavigationLink(destination: PlanDateView()) {
                                VStack(spacing: 10) {
                                    Image(systemName: "mappin.and.ellipse") // Icon for Nearby Offers
                                        .font(.system(size: 30))
                                    Text("Date Offers")
                                        .font(.headline)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                    // Subscription Options
//                    HStack {
//                        VStack {
//                            Text("Most Popular")
//                            Text("Premium")
//                            Text("$139/m")
//                        }
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//
//                        VStack {
//                            Text("Elite")
//                            Text("Unlimited")
//                            Text("$199/m")
//                        }
//                        .padding()
//                        .background(Color.pink)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                    }
//                    .padding(.horizontal)

                    // Game Cards
                    HStack(spacing: 15) {
                        GameCardA(title: "Truths and Lie", description: "Share three statements, guess the lie!", icon: "dice")
                        GameCardA(title: "What if you", description: "Make fun choices together!", icon: "questionmark.circle")
                    }
                    .padding(.horizontal)

                    // Recent Games
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recent Games")
                            .font(.headline)
                            .padding(.leading)

                        RecentGameRowA(name: "Sarah", game: "Two Truths and a Lie", time: "2h ago")
                        RecentGameRowA(name: "Mike", game: "Would You Rather", time: "5h ago")
                    }

                    // Start New Game Button
                    GradientButtonA(text: "Start New Game", action: {
                        // Implement start new game action
                    })
                    .padding()
                    Spacer()
                }
                .padding(.bottom, 40)
            }
            .navigationBarHidden(true)
            // Profile Icon (Top Left)
            
            // Side Menu
//            SideMenuView(isShowing: $showDrawer) {
//                // Drawer Content
//                VStack(alignment: .leading, spacing: 20) {
//                    NavigationLink(destination: ProfileView()) { // Use NavigationLink
//                        Text("Profile")
//                    }
//                    NavigationLink(destination: MatchesView()) {
//                        Text("Matches")
//                    }
//                    NavigationLink(destination: SettingsView()) {
//                        Text("Settings")
//                    }
//                    Spacer()
//                }
//                .padding()
//            }
        }
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

struct HomeView_PreviewsA: PreviewProvider {
    static var previews: some View {
        HomeViewA()
    }
}

// Data structure to hold connection information
struct ConnectionA: Identifiable {
    let id = UUID()
    let name: String
    let startDate: String
    let endDate: String
}

struct ProfileViewA: View {
    var body: some View {
        Text("Profile View")
    }
}

struct MatchesViewA: View {
    var body: some View {
        Text("Matches View")
    }
}

struct SettingsViewA: View {
    var body: some View {
        Text("Settings View")
    }
}

// Game Card View
struct GameCardA: View {
    let title: String
    let description: String
    let icon: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 30))
                .padding(.top)

            Text(title)
                .font(.headline)
                .padding(.top, 8)

            Text(description)
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Shadow
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1) // Elevation effect
        )
    }
}

// Recent Game Row View
struct RecentGameRowA: View {
    let name: String
    let game: String
    let time: String

    var body: some View {
        HStack {
            Image(systemName: "person.circle") // Placeholder for user image
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)

            VStack(alignment: .leading) {
                Text(name)
                Text(game)
                    .font(.caption)
            }

            Spacer()

            Text(time)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

// Gradient Button View
struct GradientButtonA: View {
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
        }
    }
}
