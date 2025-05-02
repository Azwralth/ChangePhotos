//
//  ValidationService.swift
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

import Foundation

enum FieldType {
    case email
    case password
    case confirmPassword
    
    var placeholder: String {
        switch self {
        case .email: "Enter your email"
        case .password: "Enter your password"
        case .confirmPassword: "Confirm your password"
        }
    }
    
    var iconName: String {
        switch self {
        case .email:
            "person.crop.circle"
        case .password:
            "lock"
        case .confirmPassword:
            "lock"
        }
    }
    
    func validate(value: String, confirmPassword: String? = nil) -> String? {
        switch self {
        case .email:
            return emailValidate(value: value)
        case .password:
            return passwordValidate(value: value)
        case .confirmPassword:
            return confirmPasswordValidate(value: value, confirmPassword: confirmPassword)
        }
    }
    
    private func emailValidate(value: String) -> String? {
        guard !value.isEmpty else { return "Please enter your email" }
        
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: value) ? nil : "Invalid email format"
    }
    
    private func passwordValidate(value: String) -> String? {
        guard !value.isEmpty else { return "Please enter your password" }
        return nil
    }
    
    private func confirmPasswordValidate(value: String, confirmPassword: String?) -> String? {
        guard !value.isEmpty else { return "Please confirm your password" }
        guard value == confirmPassword else { return "Passwords do not match" }
        return nil
    }
}
