//
//  ContentView.swift
//  Jina
//
//  Created by Schannikov Timothy on 07.04.2024.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var showingAlert = false
    @State var loginError: Error?
    
    var body: some View{
        VStack {
            Text("Hello")
            TextField("Email", text: $email)
            TextField("Pass", text: $password)
            
            Button {
                Task {
                    do {
                        try await AuthService.shared.signUpUser(with:email, password: password)
                    } catch {
                        loginError = error
                        showingAlert.toggle()
                    }
                    
                }
                
            } label: {
                Text("SignUp")
            }
            .alert(loginError?.localizedDescription ?? "Auth error!", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }

            
        }
    }
}

#Preview {
    ContentView(email: "", password: "")
}
