//
//  WelcomeScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 08.04.2024.
//

import SwiftUI

struct WelcomeScreen: View {
    @State var showBottomSheet = false
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
                    RegistrationView()
                        .padding()
                        .presentationDetents([.medium])
                        .presentationDetents([.height(600)])
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    WelcomeScreen()
}
