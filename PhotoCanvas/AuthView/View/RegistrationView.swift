//
//  RegistrationView.swift
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

import SwiftUI

struct RegistrationView: View {    
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 35) {
            CustomTextField(
                placeholder: viewModel.registerField.fieldType.placeholder,
                iconName: viewModel.registerField.fieldType.iconName,
                text: $viewModel.registerField.value
            )
                .textInputAutocapitalization(.never)
                .overlayValidation(error: viewModel.registerField.error)
            
            CustomTextField(
                placeholder: viewModel.registerPasswordField.fieldType.placeholder,
                iconName: viewModel.registerPasswordField.fieldType.iconName,
                text: $viewModel.registerPasswordField.value,
                isSecure: true
            )
            .overlayValidation(error: viewModel.registerPasswordField.error)
            
            
            VStack(spacing: 16) {
                Button {
                    Task {
                        await viewModel.sighUp()
                    }
                } label: {
                    Text("CREATE ACCOUNT")
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
            
            HStack {
                Text("Already have an account?")
                Button {
                    withAnimation {
                        viewModel.startView = .login
                    }
                } label: {
                    Text("Log In")
                        .foregroundStyle(.purple.opacity(0.8))
                        .font(.system(size: 18))
                }
            }
        }
        .padding(.horizontal, 30)
        .alert(isPresented: $viewModel.showRegistrationAlert) {
            Alert(
                title: Text("Регистрация"),
                message: Text(viewModel.registrationMessage),
                dismissButton: .default(Text("ОК"), action: {})
            )
        }
        .onDisappear {
            viewModel.clearRegistrationFields()
        }
    }
}

#Preview {
    RegistrationView(viewModel: AuthViewModel(authManager: AuthenticationManager()))
}
