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

#Preview {
    MarketView(presenter: MarketPresenter())
} 
