import SwiftUI

@main
struct ThemeAppApp: App {
    @State private var selectedTab = 0
    @State private var selectedTheme: Theme?
    @State private var showingWidgetManager = false
    @State private var widgetManagerTheme: Theme?
    @StateObject private var appleSignInManager = AppleSignInManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack {
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
                    
                    VStack {
                        Spacer()
                        CustomTabBar(selectedTab: $selectedTab)
                    }
                }
                .navigationBarHidden(true)
            }
            .onReceive(NotificationCenter.default.publisher(for: .navigateToThemeDetail)) { notification in
                if let theme = notification.object as? Theme {
                    DispatchQueue.main.async {
                        self.selectedTheme = theme
                    }
                }
            }
            .sheet(item: $selectedTheme) { theme in
                NavigationView {
                    ThemeDetailView(presenter: ThemeDetailPresenter(theme: theme))
                }
            }
        }
    }
} 