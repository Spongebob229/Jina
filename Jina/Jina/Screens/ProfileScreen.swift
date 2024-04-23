//
//  ProfileScreen.swift
//  Jina
//
//  Created by Schannikov Timothy on 11.04.2024.
//

import SwiftUI

struct ProfileScreen: View {
    @State private var showOnCheckScreen: Bool = false
    @State private var showSettingsScreen: Bool = false
    @State private var status: GettingDataStatus = .loading
    @State private var pickerSelection = 0
    @State private var onReviewModels: [TrashModel] = []

    @Binding var error: Error?
    @Binding var trashModel: TrashModel?
    @Binding var userModel: UserModel?
   
    let email: String = AuthService.shared.user?.email ?? ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        showSettingsScreen.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .scaledToFill()
                            .frame(minWidth: 24, minHeight: 24)
                    }
                }
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 45)
                    .padding(.bottom, 20)
                    .frame(width: 120, height: 120)
                Text("\(userModel?.name ?? "") \(userModel?.surname ?? "")")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(.black)
                    .padding(.bottom, 8)
                Text("\(email)")
                    .font(.system(size: 16, weight: .semibold))
                    .tint(.gray)
                    .foregroundColor(.gray)
                    .textSelection(.disabled)
                    .padding(.bottom, 24)
                StatisticsPanel(userModel: $userModel)
                    .padding(.bottom, 16)
                
                Picker("What is your favorite color?", selection: $pickerSelection) {
                    Text("In progress").tag(0)
                    Text("On review").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.bottom, 16)
                .onChange(of: pickerSelection) {
                    switch pickerSelection {
                    case 0: 
                        Task {
                            do {
                                if let userModel {
                                    trashModel = try await DatabaseService.shared.getCurrentTrash(id: userModel.trashModelId)
                                }
                            } catch {
                                self.error = error
                            }
                        }
                    case 1:
                        Task {
                            onReviewModels = try await DatabaseService.shared.getListUserItems(for: .onReview)
                        }

                    default:
                        break
                    }
                }
                
                    if pickerSelection == 0 {
                        InProgressView(showOnCheckScreen: $showOnCheckScreen, model: $trashModel, error: $error)
                        
                    }
                
                    if pickerSelection == 1 {
                        ScrollView {
                            if !onReviewModels.isEmpty {
                                LazyVStack {
                                    ForEach(onReviewModels) { model in
                                        ReviewElement(model: model)
                                            .padding(.bottom, 16)
                                            .cornerRadius(8)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(.gray, lineWidth: 3)
                                            )
                                    }
                                }
                            }
                        }
                        .onAppear {
                            Task {
                                onReviewModels = try await DatabaseService.shared.getListUserItems(for: .onReview)
                            }
                        }
                    }
                
                
                NavigationLink(isActive: $showOnCheckScreen) {
                    if let trashModel {
                        OnCheckScreen(trashModel: trashModel)
                    }
                   
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $showSettingsScreen) {
                   SettingsScreen()
                } label: {
                    EmptyView()
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}


/**
 VStack {
 Button("Logout") {
 try? AuthService.shared.logout()
 }
 
 
 ScrollView {
 if !models.isEmpty {
 LazyVStack {
 ForEach($models) { model in
 PostElement(model: model) {}
 }
 }
 .background(Color.textField)
 }
 }
 .padding(.top, 1)
 
 #Preview {
 ProfileScreen(models: .constant([TrashModel]()))
 }
 
 }
 */
