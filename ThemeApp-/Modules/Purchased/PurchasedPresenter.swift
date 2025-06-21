import SwiftUI

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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            self.purchasedThemes = [
                Theme.mockTheme,
            ]
        }
    }
} 