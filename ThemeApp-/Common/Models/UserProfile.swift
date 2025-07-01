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
} 
