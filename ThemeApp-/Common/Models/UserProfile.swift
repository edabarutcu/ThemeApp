//
//  UserProfile.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import Foundation

struct UserProfile: Codable {
    let id: String
    let name: String
    let email: String
    let isPremium: Bool
    let purchasedThemes: Int
    let downloadedThemes: Int
    let favoriteThemes: Int
    let joinDate: Date
    let lastActive: Date
    
    static let mockProfile = UserProfile(
        id: "user_123",
        name: "Ahmet Yılmaz",
        email: "ahmet@example.com",
        isPremium: true,
        purchasedThemes: 8,
        downloadedThemes: 15,
        favoriteThemes: 12,
        joinDate: Date().addingTimeInterval(-86400 * 30), // 30 days ago
        lastActive: Date()
    )
} 