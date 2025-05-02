//
//  AuthManager.swift
//  PhotoCanvas
//
//  Created by Владислав Соколов on 01.05.2025.
//

import FirebaseAuth
import FirebaseCore
import GoogleSignIn

protocol AuthenticationManagerProtocol {
    func signIn(email: String, password: String) async throws -> AuthDataResult
    func signUp(email: String, password: String) async throws -> AuthDataResult
    func resetPassword(email: String) async throws
    func signInWithGoogle() async throws -> AuthDataResult
}

final class AuthenticationManager: AuthenticationManagerProtocol {

    func signIn(email: String, password: String) async throws -> AuthDataResult {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    func signUp(email: String, password: String) async throws -> AuthDataResult {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }

    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    func signInWithGoogle() async throws -> AuthDataResult {
        let helper = SignInWithGoogleHelper()
        let tokens = try await helper.signIn()

        let credential = GoogleAuthProvider.credential(
            withIDToken: tokens.idToken,
            accessToken: tokens.accessToken
        )

        return try await Auth.auth().signIn(with: credential)
    }
}

