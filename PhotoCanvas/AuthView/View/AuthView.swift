//
//  AuthView.swift
//  ChangePhotos
//
//  Created by Владислав Соколов on 28.04.2025.
//

import SwiftUI

enum StartView {
    case login
    case registration
}

struct AuthView: View {
    @StateObject var viewModel = AuthViewModel(authManager: AuthenticationManager())
    
    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                MainView()
            } else {
                VStack {
                    changeStartView(viewModel.startView)
                }
                .sheet(isPresented: $viewModel.isPresented) {
                    ResetPassword(viewModel: viewModel)
                        .presentationDetents([.height(viewModel.sheetHeight)])
                        .background(
                            GeometryReader { geometry in
                                Color.clear
                                    .onAppear {
                                        viewModel.sheetHeight = geometry.size.height
                                    }
                            }
                        )
                }
            }
        }
    }
    
    @ViewBuilder
    func changeStartView(_ startView: StartView) -> some View {
        switch startView {
        case .login:
            LoginView(viewModel: viewModel)
        case .registration:
            RegistrationView(viewModel: viewModel)
        }
    }
}

#Preview {
    AuthView()
}
