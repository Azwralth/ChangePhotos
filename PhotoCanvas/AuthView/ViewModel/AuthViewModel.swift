//
//  AuthViewModel.swift
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

import FirebaseAuth

enum AuthError: LocalizedError {
    case emailNotVerified
    
    var errorDescription: String? {
        switch self {
        case .emailNotVerified:
            return "Подтвердите ваш email, прежде чем войти в аккаунт."
        }
    }
}

final class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    @Published var isPresented = false
    @Published var startView: StartView = .login
    @Published var sheetHeight = 0.0
    
    @Published var registerField = FieldModel(value: "", fieldType: .email)
    @Published var registerPasswordField = FieldModel(value: "", fieldType: .password)
    @Published var showRegistrationAlert = false
    @Published var registrationMessage = ""

    @Published var loginField = FieldModel(value: "", fieldType: .email)
    @Published var passwordField = FieldModel(value: "", fieldType: .password)
    @Published var showLoginErrorAlert = false
    @Published var loginErrorMessage = ""

    @Published var resetPasswordField = FieldModel(value: "", fieldType: .email)
    @Published var showResetAlert = false
    @Published var resetAlertMessage = ""

    private let authManager: AuthenticationManagerProtocol
    
    init(authManager: AuthenticationManagerProtocol) {
        self.authManager = authManager
    }
    
    func validateLoginFields() -> Bool {
        let isEmailValid = loginField.validate()
        let isPasswordValid = passwordField.validate()
        return isEmailValid && isPasswordValid
    }
    
    func validateResetPasswordField() -> Bool {
        let isEmailValid = resetPasswordField.validate()
        return isEmailValid
    }
    
    func validateRegistrationFields() -> Bool {
        let isEmailValid = registerField.validate()
        let isPasswordValid = registerPasswordField.validate()
        return isEmailValid && isPasswordValid
    }
    
    func clearLoginFields() {
        loginField = FieldModel(value: "", fieldType: .email)
        passwordField = FieldModel(value: "", fieldType: .password)
    }

    func clearRegistrationFields() {
        registerField = FieldModel(value: "", fieldType: .email)
        registerPasswordField = FieldModel(value: "", fieldType: .password)
    }

    func clearResetPasswordField() {
        resetPasswordField = FieldModel(value: "", fieldType: .email)
    }
    
    @MainActor
    func sighIn() async {
        guard validateLoginFields() else { return }
        
        do {
            let result = try await authManager.signIn(email: loginField.value, password: passwordField.value)
            
            if !result.user.isEmailVerified {
                try Auth.auth().signOut()
                throw AuthError.emailNotVerified
            }
            isAuthenticated = true
            
        } catch {
            print("Ошибка: \(error.localizedDescription)")
        }
    }
    
    func signInWithGoogle() async {
        do {
            let result = try await authManager.signInWithGoogle()
            print("Google Sign-In successful: \(result.user.email ?? "")")
            isAuthenticated = true
        } catch {
            print("Google Sign-In error: \(error.localizedDescription)")
            // Можно добавить алерт-переменную и отобразить ошибку в интерфейсе
        }
    }

    
    @MainActor
    func sighUp() async {
        guard validateRegistrationFields() else { return }
        
        do {
            let result = try await Auth.auth().createUser(withEmail: registerField.value,
                                                          password: registerPasswordField.value)
            try await result.user.sendEmailVerification()
            
            await MainActor.run {
                registrationMessage = "Мы отправили письмо с подтверждением на \(registerField.value). Подтвердите email перед входом."
                showRegistrationAlert = true
            }
        } catch {
            await MainActor.run {
                registrationMessage = "Ошибка регистрации: \(error.localizedDescription)"
                showRegistrationAlert = true
            }
        }
    }
    
    @MainActor
    func resetPassword() async {
        guard validateResetPasswordField() else { return }
        
        do {
            try await authManager.resetPassword(email: resetPasswordField.value)
            await MainActor.run {
                resetAlertMessage = "Письмо для сброса пароля отправлено на \(resetPasswordField.value)"
                showResetAlert = true
            }
        } catch {
            await MainActor.run {
                resetAlertMessage = "Не удалось отправить письмо: \(error.localizedDescription)"
                showResetAlert = true
            }
        }
    }
}
