//
//  AuthService.swift
//  Jina
//
//  Created by Schannikov Timothy on 07.04.2024.
//

import Foundation
import Firebase

final class AuthService {
    static let shared = AuthService()
    
    private var auth = Auth.auth()

    var user: User? {
        auth.currentUser
    }

    private init() {}
    
    func signUpUser(with email: String, password: String) async throws {
        _ = try await auth.createUser(withEmail: email, password: password)
    }
    
    func signInUser(with email: String, password: String) async throws {
        _ = try await auth.signIn(withEmail: email, password: password)
    }

    func logout() throws {
        try auth.signOut()
    }
}
