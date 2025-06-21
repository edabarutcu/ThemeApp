//
//  PurchasedThemeCard.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//


import SwiftUI

struct PurchasedThemeCard: View {
    let theme: Theme
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(theme.primaryColor)
                    .frame(height: 120)
                    .overlay(
                        VStack(spacing: 8) {
                            Image(systemName: theme.iconName)
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                            
                            HStack(spacing: 4) {
                                Image(systemName: "rectangle.stack.fill")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                Text("\(theme.widgets.filter { $0.isIncluded }.count)")
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(8)
                        }
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(theme.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(theme.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(L10n.Theme.purchased.localized)
                                .font(.caption)
                                .foregroundColor(.green)
                                .fontWeight(.semibold)
                            
                            Text("\(theme.widgets.filter { $0.isIncluded }.count) widget")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                        }) {
                            Text(L10n.Theme.apply.localized)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(theme.primaryColor)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
            }
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    PurchasedThemeCard(theme: Theme.mockTheme) {
    }
} 
