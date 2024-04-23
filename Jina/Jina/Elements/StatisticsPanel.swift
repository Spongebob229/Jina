//
//  StatisticsPanel.swift
//  Jina
//
//  Created by Schannikov Timothy on 15.04.2024.
//

import SwiftUI

struct StatisticsPanel: View {
    @Binding var userModel: UserModel?
    var body: some View {
        if let userModel {
            HStack (spacing: 0){
                VStack(alignment: .center, spacing: 0) {
                    Text("Diamonds")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.bottom, 10)
                    
                    Text("\(userModel.stars)")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                }
                
                
                
                Stripe()
                
                VStack(spacing: 0) {
                    Text("Cleaned")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.bottom, 10)
                    Text("\(userModel.completed)")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                }
                
                Stripe()
                
                VStack(spacing: 0) {
                    Text("Posts")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.bottom, 10)
                    Text("\(userModel.posted)")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 90, maxHeight: 90)
            .background(Color.blue)
            .cornerRadius(8)
        }
    }
}
