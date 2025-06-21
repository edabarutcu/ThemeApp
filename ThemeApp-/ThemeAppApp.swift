//
//  ThemeAppApp.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import SwiftUI

@main
struct ThemeAppApp: App {
    @State private var selectedTab = 0
    @State private var showingThemeDetail = false
    @State private var selectedTheme: Theme?
    @State private var showingWidgetManager = false
    @State private var widgetManagerTheme: Theme?
    @StateObject private var appleSignInManager = AppleSignInManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack {
                    // Main content
                    TabView(selection: $selectedTab) {
                        MarketView(presenter: MarketPresenter())
                            .tag(0)
                        
                        PurchasedView()
                            .tag(1)
                        
                        ProfileView(presenter: ProfilePresenter())
                            .environmentObject(appleSignInManager)
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    // Custom Tab Bar
                    VStack {
                        Spacer()
                        CustomTabBar(selectedTab: $selectedTab)
                    }
                }
                .navigationBarHidden(true)
            }
            .onReceive(NotificationCenter.default.publisher(for: .navigateToThemeDetail)) { notification in
                if let theme = notification.object as? Theme {
                    selectedTheme = theme
                    showingThemeDetail = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .navigateToWidgetPreview)) { notification in
                if let widget = notification.object as? Widget {
                    // Handle widget preview navigation
                    print("Navigate to widget preview: \(widget.name)")
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .navigateToWidgetSettings)) { notification in
                if let widget = notification.object as? Widget {
                    // Handle widget settings navigation
                    print("Navigate to widget settings: \(widget.name)")
                }
            }
            .sheet(isPresented: $showingThemeDetail) {
                if let theme = selectedTheme {
                    NavigationView {
                        ThemeDetailView(presenter: ThemeDetailPresenter(theme: theme))
                    }
                }
            }
        }
    }
}

// Purchased Themes View
struct PurchasedView: View {
    @StateObject private var presenter = PurchasedPresenter()
    
    var body: some View {
        Group {
            if presenter.isLoading {
                ProgressView("Yükleniyor...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if presenter.purchasedThemes.isEmpty {
                emptyStateView
            } else {
                purchasedThemesList
            }
        }
        .navigationTitle("Satın Aldıklarım")
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
            
            Text("Henüz tema satın almadınız")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Market'ten tema seçerek satın alabilir ve burada görüntüleyebilirsiniz.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                // Navigate to market tab
            }) {
                HStack {
                    Image(systemName: "storefront")
                    Text("Market'e Git")
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
                        // Navigate to theme detail
                    }
                }
            }
            .padding()
        }
    }
}

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
                            Text("Satın Alındı")
                                .font(.caption)
                                .foregroundColor(.green)
                                .fontWeight(.semibold)
                            
                            Text("\(theme.widgets.filter { $0.isIncluded }.count) widget")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Apply theme
                        }) {
                            Text("Uygula")
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

// Purchased Presenter
@MainActor
class PurchasedPresenter: ObservableObject {
    @Published var purchasedThemes: [Theme] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        loadPurchasedThemes()
    }
    
    func loadPurchasedThemes() {
        isLoading = true
        
        // Simulate loading purchased themes
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            // Mock purchased themes - in real app this would come from user's purchase history
            self.purchasedThemes = [
                Theme.mockTheme,
                // Add more mock purchased themes here
            ]
        }
    }
} 