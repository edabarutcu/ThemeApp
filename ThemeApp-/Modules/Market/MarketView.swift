//
//  MarketView.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import SwiftUI

struct MarketView: View {
    @ObservedObject var presenter: MarketPresenter
    
    var body: some View {
        NavigationView {
            Group {
                if presenter.isLoading {
                    ProgressView(L10n.Loading.loading.localized)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                            ForEach(presenter.themes, id: \.id) { theme in
                                ThemeCard(theme: theme) {
                                    presenter.selectTheme(theme)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                presenter.loadThemes()
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ThemeCard: View {
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
                            
                            // Widget count badge
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
                            Text("₺\(theme.price, specifier: "%.2f")")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            
                            Text("\(theme.widgets.filter { $0.isIncluded }.count) widget")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        if theme.isPremium {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.yellow)
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
    MarketView(presenter: MarketPresenter())
} 