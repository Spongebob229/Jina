//
//  WelcomeScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 08.04.2024.
//

import SwiftUI

struct WelcomeScreen: View {
    @State var showBottomSheet = false
    @State var entryType: EntryType = .signIn
    var body: some View {
        ZStack {
            Image("WelcomeScreenImage")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                MainTitle(title: "Welcome to Jina", color: Color.white)
                Spacer()
                MainButton(title: "Continue") {
                    showBottomSheet.toggle()
                }
                .sheet(isPresented: $showBottomSheet) {
                    if(entryType == .signIn) {
                        LoginView(entryType: $entryType)
                            .padding()
                            .presentationDetents([.medium])
                    }
                    else {
                        RegistrationView(entryType: $entryType)
                            .padding()
                            .presentationDetents([.medium])
                            .presentationDetents([.height(600)])
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    WelcomeScreen()
}
