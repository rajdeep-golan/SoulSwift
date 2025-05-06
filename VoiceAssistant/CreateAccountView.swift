//
//  LoginView.swift
//  Soul
//
//  Created by Prakashdeep Golan on 3/11/25.
//

import SwiftUI
//import FirebaseAuth

struct CreateAccountView: View {
   @State private var email = ""
   @State private var password = ""
   @State private var showAlert = false
   @State private var alertMessage = ""
    @State private var isContentViewPresented = false


   var body: some View {
       NavigationView {
           ZStack{
               LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.3), Color(red: 0.9, green: 0.1, blue: 0.3)]), startPoint: .top, endPoint: .bottom)
                   .edgesIgnoringSafeArea(.all)
               VStack(spacing: 20) {
                   HStack {
                       Spacer()
                       Text("Welcome!")
                           .font(.largeTitle)
                           .fontWeight(.bold)
                      
                       
                       Spacer()
                   }
                   HStack {
                       Spacer()
                       Image(systemName: "person.circle") // Replace with your AI icon
                           .font(.system(size: 30))
                       
                       Text("Create Account")
                           .font(.title2)
                           .fontWeight(.bold)
                       
                       Spacer()
                   }
                   
                   VStack(alignment: .leading, spacing: 10) {
                       Text("Email")
                           .font(.headline)
                       
                       TextField("Enter your email", text: $email)
                           .padding()
                           .background(
                                   Color.white.opacity(0.1) // Semi-transparent white
                                       .blur(radius: 10) // Apply a blur effect
                               )
                               .overlay(
                                   RoundedRectangle(cornerRadius: 8)
                                       .stroke(Color.white.opacity(0.3), lineWidth: 1) // Subtle border
                               )
                            .foregroundColor(.white)
                           .cornerRadius(8)
                       
                       Text("Password")
                           .font(.headline)
                       
                       SecureField("Choose a password", text: $password)
                           .padding()
                           .background(
                               Color.white.opacity(0.1) // Semi-transparent white
                                   .blur(radius: 10) // Apply a blur effect
                           )
                           .overlay(
                               RoundedRectangle(cornerRadius: 8)
                                   .stroke(Color.white.opacity(0.3), lineWidth: 1) // Subtle border
                           )
                           .foregroundColor(.white)
                           .cornerRadius(8)
                   }
                   .padding(.horizontal, 20)
                   
                   Button(action: {
                       isContentViewPresented = true
//                       createAccount()
                   }) {
                       Text("Create Account")
                           .font(.headline)
                           .foregroundColor(Color.black)
                           .padding()
                           .frame(maxWidth: .infinity)
                           .background(Color.white)
                           .cornerRadius(10)
                   }
                   .sheet(isPresented: $isContentViewPresented) {
                                   ContentView()
                               }
                   .padding(.horizontal, 20)
                   
                   HStack {
                       Text("Already have an account?")
                       Button(action: {
                           // Action for Login link
                       }) {
                           NavigationLink(destination: LoginView()) {
                               Text("Login")
                                   .fontWeight(.bold)
                                   .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.3))
                           }
                       }
                   }
                   
                   Spacer()
               }
               .padding(.vertical, 40)
               .alert(isPresented: $showAlert) {
                   Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
               }
           }
       }.navigationBarHidden(true)
   }

   func createAccount() {
//       ContentView()
       
//       Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//           if let error = error {
//               alertMessage = error.localizedDescription
//               showAlert = true
//               return
//           }
//           // Account creation successful
//           // Navigate to the next screen or show a success message
//       }
   }
}

struct CreateAccountView_Previews: PreviewProvider {
   static var previews: some View {
       CreateAccountView()
   }
}
