//
//  PostList.swift
//  Jina
//
//  Created by Schannikov Timothy on 10.04.2024.
//

import SwiftUI

struct PostList: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1..<10) {_ in
                    PostElement()
                }
            }
            .background(Color.textField)
            
        }
        .padding(.top, 1)
    }
}

#Preview {
    PostList()
}
