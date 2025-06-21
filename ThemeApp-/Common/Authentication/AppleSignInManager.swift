//
//  AppleSignInManager.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import Foundation
import AuthenticationServices
import Combine

@MainActor
class AppleSignInManager: NSObject, ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: AppleUser?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        checkAuthenticationStatus()
    }
    
    func signInWithApple() {
        isLoading = true
        errorMessage = nil
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func signOut() {
        isLoading = true
        
        // Clear user data
        UserDefaults.standard.removeObject(forKey: "appleUserID")
        UserDefaults.standard.removeObject(forKey: "appleUserEmail")
        UserDefaults.standard.removeObject(forKey: "appleUserName")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isAuthenticated = false
            self.currentUser = nil
            self.isLoading = false
        }
    }
    
    private func checkAuthenticationStatus() {
        guard let userID = UserDefaults.standard.string(forKey: "appleUserID") else {
            isAuthenticated = false
            return
        }
        
        let provider = ASAuthorizationAppleIDProvider()
        provider.getCredentialState(forUserID: userID) { [weak self] state, error in
            DispatchQueue.main.async {
                switch state {
                case .authorized:
                    self?.loadUserData()
                case .revoked, .notFound:
                    self?.signOut()
                default:
                    self?.isAuthenticated = false
                }
            }
        }
    }
    
    private func loadUserData() {
        guard let userID = UserDefaults.standard.string(forKey: "appleUserID"),
              let email = UserDefaults.standard.string(forKey: "appleUserEmail"),
              let name = UserDefaults.standard.string(forKey: "appleUserName") else {
            isAuthenticated = false
            return
        }
        
        currentUser = AppleUser(
            id: userID,
            email: email,
            name: name
        )
        isAuthenticated = true
    }
    
    private func saveUserData(_ user: AppleUser) {
        UserDefaults.standard.set(user.id, forKey: "appleUserID")
        UserDefaults.standard.set(user.email, forKey: "appleUserEmail")
        UserDefaults.standard.set(user.name, forKey: "appleUserName")
    }
}

// MARK: - ASAuthorizationControllerDelegate
extension AppleSignInManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
            let email = appleIDCredential.email ?? ""
            let fullName = appleIDCredential.fullName
            
            let name = [fullName?.givenName, fullName?.familyName]
                .compactMap { $0 }
                .joined(separator: " ")
            
            let user = AppleUser(
                id: userID,
                email: email,
                name: name.isEmpty ? "Kullanıcı" : name
            )
            
            saveUserData(user)
            currentUser = user
            isAuthenticated = true
            isLoading = false
            
            DispatchQueue.main.async { [weak self] in
                self?.isAuthenticated = true
                self?.currentUser = user
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        isLoading = false
        
        if let authError = error as? ASAuthorizationError {
            errorMessage = "Giriş hatası: \(authError.localizedDescription)"
        } else {
            errorMessage = "Giriş sırasında hata oluştu"
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.isAuthenticated = false
            self?.currentUser = nil
        }
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension AppleSignInManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            fatalError("No window found")
        }
        return window
    }
}

// MARK: - Apple User Model
struct AppleUser: Codable {
    let id: String
    let email: String
    let name: String
} 
