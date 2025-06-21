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
                    profileHeader
                    
                    // Stats section
                    statsSection
                    
                    // Menu items
                    menuSection
                }
            }
            .padding()
        }
        .navigationTitle("Profil")
        .navigationBarTitleDisplayMode(.large)
        .alert("Hata", isPresented: $showingError) {
            Button("Tamam") { }
        } message: {
            Text(appleSignInManager.errorMessage ?? "Bilinmeyen hata")
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
                    
                    Text("Giriş Yapın")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Tema satın alma ve kişiselleştirme için Apple ID ile giriş yapın.")
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
            // Profile image
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
            
            // Premium badge
            if presenter.userProfile.isPremium {
                HStack {
                    Image(systemName: "crown.fill")
                        .foregroundColor(.yellow)
                    Text("Premium Üye")
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
        HStack(spacing: 20) {
            StatCard(
                title: "Satın Alınan",
                value: "\(presenter.userProfile.purchasedThemes)",
                icon: "bag.fill",
                color: .blue
            )
            
            StatCard(
                title: "İndirilen",
                value: "\(presenter.userProfile.downloadedThemes)",
                icon: "arrow.down.circle.fill",
                color: .green
            )
            
            StatCard(
                title: "Uygulanan",
                value: "\(presenter.userProfile.favoriteThemes)",
                icon: "checkmark.circle.fill",
                color: .red
            )
        }
    }
    
    private var menuSection: some View {
        VStack(spacing: 8) {
            MenuRow(
                title: "Satın Alınan Temalar",
                icon: "bag.fill",
                color: .blue
            ) {
                presenter.showPurchasedThemes()
            }
            
            MenuRow(
                title: "Uygulanan Temalar",
                icon: "checkmark.circle.fill",
                color: .green
            ) {
                presenter.showAppliedThemes()
            }
            
            MenuRow(
                title: "Ayarlar",
                icon: "gear",
                color: .gray
            ) {
                presenter.showSettings()
            }
            
            MenuRow(
                title: "Yardım & Destek",
                icon: "questionmark.circle.fill",
                color: .orange
            ) {
                presenter.showHelp()
            }
            
            MenuRow(
                title: "Hakkında",
                icon: "info.circle.fill",
                color: .purple
            ) {
                presenter.showAbout()
            }
        }
        .background(Color(.systemGray6))
        .cornerRadius(12)
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

struct MenuRow: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
                    .frame(width: 24)
                
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ProfileView(presenter: ProfilePresenter())
        .environmentObject(AppleSignInManager())
} 