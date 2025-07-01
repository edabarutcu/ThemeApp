//
//  AppleSignInButton.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import SwiftUI
import AuthenticationServices

struct AppleSignInButton: View {
    let action: () -> Void
    let isLoading: Bool
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: "applelogo")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Text(isLoading ? L10n.Auth.signingIn.localized : L10n.Auth.signInWithApple.localized)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.black)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .disabled(isLoading)
        .buttonStyle(PlainButtonStyle())
    }
}

struct AppleSignOutButton: View {
    let action: () -> Void
    let isLoading: Bool
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .red))
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.title2)
                        .foregroundColor(.red)
                }
                
                Text(isLoading ? L10n.Auth.signingOut.localized : L10n.Auth.signOut.localized)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.red.opacity(0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.red, lineWidth: 1)
            )
        }
        .disabled(isLoading)
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        AppleSignInButton(action: {}, isLoading: false)
        AppleSignInButton(action: {}, isLoading: true)
        AppleSignOutButton(action: {}, isLoading: false)
        UserInfoCard(user: AppleUser(id: "123", email: "test@example.com", name: "Test User"))
    }
    .padding()
} 
