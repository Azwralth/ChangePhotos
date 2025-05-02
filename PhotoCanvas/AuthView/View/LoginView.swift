//
//  LoginView.swift
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 35) {
            CustomTextField(placeholder: viewModel.loginField.fieldType.placeholder, iconName: viewModel.loginField.fieldType.iconName, text: $viewModel.loginField.value)
                .textInputAutocapitalization(.never)
                .overlayValidation(error: viewModel.loginField.error)
            
            CustomTextField(placeholder: viewModel.passwordField.fieldType.placeholder, iconName: viewModel.passwordField.fieldType.iconName, text: $viewModel.passwordField.value, isSecure: true)
                .overlayValidation(error: viewModel.passwordField.error)
            
            
            VStack(spacing: 16) {
                Button {
                    Task {
                        await viewModel.sighIn()
                    }
                } label: {
                    Text("LOGIN")
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
                
                
                Button {
                    withAnimation {
                        viewModel.isPresented.toggle()
                    }
                } label: {
                    Text("Forgot Password?")
                        .foregroundStyle(.purple.opacity(0.8))
                        .font(.system(size: 14))
                }
            }
            
            HStack {
                Text("Don't have an account?")
                Button {
                    withAnimation {
                        viewModel.startView = .registration
                    }
                } label: {
                    Text("Sign Up")
                        .foregroundStyle(.purple.opacity(0.8))
                        .font(.system(size: 18))
                }
            }
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.5))
                
                Text("OR")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.5))
            }
            
            Text("Sign up with Social Networks")
                .font(.system(size: 16))
            
            Button {
                Task {
                    await viewModel.signInWithGoogle()
                }
            } label: {
                HStack {
                    Image("google_icon")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Continue with Google")
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(22)
                .shadow(color: .gray.opacity(0.4), radius: 3, x: 0, y: 2)
                
            }
        }
        .padding(.horizontal, 30)
        .onDisappear {
            viewModel.clearLoginFields()
        }
    }
}

#Preview {
    LoginView(viewModel: AuthViewModel(authManager: AuthenticationManager()))
}
