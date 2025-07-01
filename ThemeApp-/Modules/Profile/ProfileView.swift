//
//  ProfileView.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var presenter: ProfilePresenter
    @EnvironmentObject var appleSignInManager: AppleSignInManager
    @State private var showingError = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Authentication section
                authenticationSection
                
                // Profile header (only show if authenticated)
                if appleSignInManager.isAuthenticated {
                    // Stats section
                    statsSection
                    // Menu items
                    menuSection
                }
            }
            .padding()
        }
        .navigationTitle(L10n.Navigation.profile.localized)
        .navigationBarTitleDisplayMode(.large)
        .alert("Hata", isPresented: $showingError) {
            Button(L10n.Auth.ok.localized) { }
        } message: {
            Text(appleSignInManager.errorMessage ?? L10n.Auth.unknownError.localized)
        }
        .onChange(of: appleSignInManager.errorMessage) { errorMessage in
            showingError = errorMessage != nil
        }
    }
    
    private var authenticationSection: some View {
        VStack(spacing: 16) {
            if appleSignInManager.isAuthenticated {
                if let user = appleSignInManager.currentUser {
                    UserInfoCard(user: user)
                }
                AppleSignOutButton(
                    action: { appleSignInManager.signOut() },
                    isLoading: appleSignInManager.isLoading
                )
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    
                    Text(L10n.Auth.signInPrompt.localized)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(L10n.Auth.signInDescription.localized)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    AppleSignInButton(
                        action: { appleSignInManager.signInWithApple() },
                        isLoading: appleSignInManager.isLoading
                    )
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
            }
        }
    }
    
    private var profileHeader: some View {
        VStack(spacing: 16) {
            Circle()
                .fill(LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 100, height: 100)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                )
            
            VStack(spacing: 4) {
                Text(presenter.userProfile.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(presenter.userProfile.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if presenter.userProfile.isPremium {
                HStack {
                    Image(systemName: "crown.fill")
                        .foregroundColor(.yellow)
                    Text(L10n.Auth.premiumMember.localized)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.yellow.opacity(0.1))
                .cornerRadius(20)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
    
    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("İstatistikler")
                .font(.headline)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                StatCard(
                    title: "Satın Alınan",
                    value: "\(presenter.userProfile.purchasedThemes)",
                    icon: "bag.fill",
                    color: .green
                )
                
                StatCard(
                    title: "Uygulanan",
                    value: "\(presenter.userProfile.downloadedThemes)",
                    icon: "checkmark.circle.fill",
                    color: .blue
                )
                
                StatCard(
                    title: "Favori",
                    value: "\(presenter.userProfile.favoriteThemes)",
                    icon: "heart.fill",
                    color: .red
                )
            }
        }
    }
    
    private var menuSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ayarlar")
                .font(.headline)
                .fontWeight(.semibold)
            
            VStack(spacing: 8) {
                MenuRow(
                    title: "Bildirimler",
                    icon: "bell.fill",
                    color: .orange
                ) {
                    // Handle notifications
                }
                
                MenuRow(
                    title: "Gizlilik",
                    icon: "lock.fill",
                    color: .green
                ) {
                    // Handle privacy
                }
                
                MenuRow(
                    title: "Yardım",
                    icon: "questionmark.circle.fill",
                    color: .blue
                ) {
                    // Handle help
                }
                
                MenuRow(
                    title: "Hakkında",
                    icon: "info.circle.fill",
                    color: .purple
                ) {
                    // Handle about
                }
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}


#Preview {
    ProfileView(presenter: ProfilePresenter())
        .environmentObject(AppleSignInManager())
} 
