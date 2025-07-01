//
//  UserInfoCard.swift
//  ThemeApp-
//
//  Created by Eda Barutçu on 1.07.2025.
//

import SwiftUI

struct UserInfoCard: View {
    let user: AppleUser
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
            }
            
            HStack {
                Label(L10n.Auth.appleIdSignedIn.localized, systemImage: "applelogo")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    UserInfoCard(user: AppleUser(id: "123", email: "test@example.com", name: "Test User"))
}
