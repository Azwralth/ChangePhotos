//
//  ResetPassword.swift
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

import SwiftUI

struct ResetPassword: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Forgot your password?")
                .font(.system(size: 18).weight(.bold))
                .foregroundStyle(.gray)
            
            Text("Tell us your email address, and we’ll get you back on trak in no time")
                .foregroundStyle(.gray)
                .padding(.trailing, 70)
            
            CustomTextField(placeholder: viewModel.resetPasswordField.fieldType.placeholder, iconName: viewModel.resetPasswordField.fieldType.iconName, text: $viewModel.resetPasswordField.value)
                .textInputAutocapitalization(.never)
                .overlayValidation(error: viewModel.resetPasswordField.error)
            
            Button {
                Task {
                    await viewModel.resetPassword()
                }
            } label: {
                Text("RESET")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.purple]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 22))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .alert(isPresented: $viewModel.showResetAlert) {
            Alert(title: Text("Сброс пароля"),
                  message: Text(viewModel.resetAlertMessage),
                  dismissButton: .default(Text("OK")))
        }
        .onDisappear {
            viewModel.clearResetPasswordField()
        }
    }
}

#Preview {
    ResetPassword(viewModel: AuthViewModel(authManager: AuthenticationManager()))
}
