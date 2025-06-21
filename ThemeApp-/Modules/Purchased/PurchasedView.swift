//
//  PurchasedView.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import SwiftUI

struct PurchasedView: View {
    @StateObject private var presenter = PurchasedPresenter()
    
    var body: some View {
        Group {
            if presenter.isLoading {
                ProgressView(L10n.Loading.loading.localized)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if presenter.purchasedThemes.isEmpty {
                emptyStateView
            } else {
                purchasedThemesList
            }
        }
        .navigationTitle(L10n.Navigation.purchased.localized)
        .navigationBarTitleDisplayMode(.large)
        .refreshable {
            presenter.loadPurchasedThemes()
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "bag")
                .font(.system(size: 60))
                .foregroundColor(.green)
            
            Text(L10n.Purchased.noPurchasedThemes.localized)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(L10n.Purchased.purchasedThemesDescription.localized)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
            }) {
                HStack {
                    Image(systemName: "storefront")
                    Text(L10n.Purchased.goToMarket.localized)
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(12)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private var purchasedThemesList: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                ForEach(presenter.purchasedThemes, id: \.id) { theme in
                    PurchasedThemeCard(theme: theme) {
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    PurchasedView()
} 
