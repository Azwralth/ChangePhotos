//
//  SignInWithGoogle.swift
//  PhotoCanvas
//
//  Created by Владислав Соколов on 02.05.2025.
//

import UIKit
import GoogleSignIn

struct GoogleSignInResult {
    let idToken: String
    let accessToken: String
}

final class SignInWithGoogleHelper {
    
    @MainActor
    func signIn(viewController: UIViewController? = nil) async throws -> GoogleSignInResult {
        guard let topViewController = viewController ?? topViewController() else {
            throw URLError(.notConnectedToInternet)
        }

        let gidResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topViewController)

        guard let idToken = gidResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }

        let accessToken = gidResult.user.accessToken.tokenString
        return GoogleSignInResult(idToken: idToken, accessToken: accessToken)
    }

    private func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        let controller = controller ?? UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController

        if let nav = controller as? UINavigationController {
            return topViewController(controller: nav.visibleViewController)
        }
        if let tab = controller as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(controller: selected)
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
