//
//  LoginView.swift
//  Jina
//
//  Created by Schannikov Timothy on 08.04.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State var showingAlert = false
    @State var loginError: Error?
    @Binding var showContentView: Bool
    @Binding var entryType: AuthType
    
    var body: some View {
            VStack(spacing: 0) {
                HStack {
                    Text("Login")
                        .padding(.bottom, 12)
                        .font(.system(size: 30, weight: .semibold))
                    Spacer()
                }
                .padding(.top)
                .padding(.bottom, 8)
                
                HStack {
                    Text("Email")
                        .padding(.bottom, 12)
                        .font(.system(size: 17))
                    Spacer()
                }
                InputField(text: $email, placeholder: "Email")
                    .padding(.bottom, 16)
                    .autocapitalization(.none)
                
                HStack {
                    Text("Password")
                        .padding(.bottom, 12)
                        .font(.system(size: 17))
                    Spacer()
                }
                SecureInputField(text: $password)
                    .padding(.bottom, 24)
                
                HStack {
                    Text("Don't have an account?")
                    Button {
                        entryType = .signUp
                    } label: {
                        Text("SIGN UP")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(Color.blue)
                    }
                    Spacer()
                }
                
                Spacer()
                
                
                
                MainButton(title: "Login") {
                    Task {
                        do {
                            try await AuthService.shared.signInUser(with: email, password: password)
                            showContentView.toggle()
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
