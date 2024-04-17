//
//  RegistrationView.swift
//  Jina
//
//  Created by Schannikov Timothy on 09.04.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var surname = ""
    @State private var email = ""
    @State private var password = ""
    @State var showingAlert = false
    @State var loginError: Error?
    @Binding var showContentView: Bool
    @Binding var entryType: EntryType
    
    var body: some View {
            ScrollView {
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
                    InputField(text: $name, placeholder: "Your name")
                        .padding(.bottom, 16)
                    
                    HStack {
                        Text("Surname")
                            .padding(.bottom, 12)
                            .font(.system(size: 17))
                        Spacer()
                    }
                    InputField(text: $surname, placeholder: "Your surname")
                        .padding(.bottom, 16)
                    
                    
                    HStack {
                        Text("Email")
                            .padding(.bottom, 12)
                            .font(.system(size: 17))
                        Spacer()
                    }
                    InputField(text: $email, placeholder: "Your email")
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
                        Text("Already have an account?")
                        Button {
                            entryType = .signIn
                        } label: {
                            Text("LOG IN")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(Color.blue)
                        }
                        Spacer()
                    }
                    
                }
                
                Spacer()
                
            }
        
            MainButton(title: "Sign up") {
                Task {
                    do {
                        try await AuthService.shared.signUpUser(with: email, password: password)
                        
                        let id = AuthService.shared.currentUser?.user.uid
                        let userModel = UserModel(id: id ?? "", trashModelId: "", stars: 0, completed: 0, posted: 0, name: name, surname: surname)
                        
                        try DatabaseService.shared.createUserDocument(user: userModel)
                        
                        showContentView.toggle()
                        print("Signed up")
                        
                        
                    } catch {
                        loginError = error
                        showingAlert.toggle()
                    }
                }
            }
            .alert(loginError?.localizedDescription ?? "Sign up error!", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            
            
        }
    }


