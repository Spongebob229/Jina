//
//  RegistrationView.swift
//  Jina
//
//  Created by Schannikov Timothy on 09.04.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    @State var showingAlert = false
    @State var loginError: Error?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Create account")
                    .padding(.bottom, 12)
                    .font(.system(size: 30, weight: .semibold))
                Spacer()
            }
            .padding(.top)
            .padding(.bottom, 8)
            
            HStack {
                Text("Name")
                    .padding(.bottom, 12)
                    .font(.system(size: 17))
                Spacer()
            }
            InputField(text: $email, placeholder: "Your name")
                .padding(.bottom, 16)
            
            HStack {
                Text("Surname")
                    .padding(.bottom, 12)
                    .font(.system(size: 17))
                Spacer()
            }
            InputField(text: $email, placeholder: "Your surname")
                .padding(.bottom, 16)
            
            
            HStack {
                Text("Email")
                    .padding(.bottom, 12)
                    .font(.system(size: 17))
                Spacer()
            }
            InputField(text: $email, placeholder: "Your email")
                .padding(.bottom, 16)
            
            HStack {
                Text("Password")
                    .padding(.bottom, 12)
                    .font(.system(size: 17))
                Spacer()
            }
            
            SecureInputField(text: $password)
                .padding(.bottom, 24)
            
            HStack {
                Text("Already have an account?")
                Button {
                    
                } label: {
                    Text("LOG IN")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color.blue)
                }
                Spacer()
            }
            
            Spacer()
            
            Spacer()
            
            MainButton(title: "Sign up") {
                Task {
                    do {
                        try await AuthService.shared.signInUser(with: email, password: password)
                        print("Logged in")
                    } catch {
                        loginError = error
                        showingAlert.toggle()
                    }
                }
            }
            .alert(loginError?.localizedDescription ?? "Login error!", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}
