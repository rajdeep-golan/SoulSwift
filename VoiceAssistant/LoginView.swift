//
//  LoginView.swift
//  Soul
//
//  Created by Prakashdeep Golan on 3/11/25.
//
import SwiftUI
//import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoggedIn = false

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.3), Color(red: 0.9, green: 0.1, blue: 0.3)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Text("Welcome Back!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                   
                    
                    Spacer()
                }
                Text("Login")
                    .font(.title2)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading) {
                    Text("Email / Phone")
                        .font(.headline)
                    
                    TextField("Email id or phone", text: $email)
                        .padding()
                        .background(
                                Color.white.opacity(0.1) // Semi-transparent white
                                    .blur(radius: 10) // Apply a blur effect
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1) // Subtle border
                            )
                         .foregroundColor(.white)
                        .cornerRadius(20)
                    
                    Text("Password")
                        .font(.headline)
                    
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(
                                Color.white.opacity(0.1) // Semi-transparent white
                                    .blur(radius: 10) // Apply a blur effect
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1) // Subtle border
                            )
                         .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.horizontal, 20)
                
                Button(action: {
                    login()
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)
                }
                
                
                .padding(.horizontal, 20)
                NavigationLink(destination: HomeViewOptions(), isActive: $isLoggedIn) {
                    EmptyView() // This is needed for NavigationLink to work programmatically
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .padding(.vertical, 40)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    func login() {
        isLoggedIn = true
//        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                alertMessage = error.localizedDescription
//                showAlert = true
//                isLoggedIn = true
//                return
//            }
//            // Login successful
//            // Navigate to the home screen or show a success message
//        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
