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
    @State var showContentView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("WelcomeScreenImage")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 0){
                    MainTitle(title: "Welcome to Jina", color: Color.white)
                    Spacer()
                    MainButton(title: "Continue") {
                        AuthService.shared.user != nil ? showContentView.toggle() : showBottomSheet.toggle()
                    }
                    .sheet(isPresented: $showBottomSheet) {
                        if(entryType == .signIn) {
                            LoginView(showContentView: $showContentView, entryType: $entryType)
                                .padding()
                                .presentationDetents([.medium])
                        }
                        else {
                            RegistrationView(showContentView: $showContentView, entryType: $entryType)
                                .padding()
                                .presentationDetents([.medium, .height(600)])
                        }
                    }
                }
                .padding()
            }
            
            NavigationLink(isActive: $showContentView) {
                ContentView()
                    .onAppear{
                        showBottomSheet = false
                    }
                    .navigationBarBackButtonHidden(true)
                
            }
            label: {
                EmptyView()
            }
            
        }
    }
}
