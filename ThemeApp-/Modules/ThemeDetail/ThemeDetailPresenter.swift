//
//  ThemeDetailPresenter.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import SwiftUI
import Combine

@MainActor
class ThemeDetailPresenter: ObservableObject {
    @Published var theme: Theme
    @Published var isPurchasing = false
    @Published var showPreview = false
    @Published var errorMessage: String?
    
    private let interactor: ThemeDetailInteractorProtocol
    private let router: ThemeDetailRouterProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(theme: Theme, interactor: ThemeDetailInteractorProtocol = ThemeDetailInteractor(), router: ThemeDetailRouterProtocol = ThemeDetailRouter()) {
        self.theme = theme
        self.interactor = interactor
        self.router = router
        setupBindings()
    }
    
    private func setupBindings() {
        interactor.purchaseResultPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.handlePurchaseResult(result)
            }
            .store(in: &cancellables)
        
        interactor.loadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.isPurchasing = isLoading
            }
            .store(in: &cancellables)
        
        interactor.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.errorMessage = error
            }
            .store(in: &cancellables)
    }
    
    func purchaseTheme() {
        interactor.purchaseTheme(theme)
    }
    
    func previewTheme() {
        showPreview = true
    }
    
    func applyTheme() {
        interactor.applyTheme(theme)
    }
    
    private func handlePurchaseResult(_ result: PurchaseResult) {
        switch result {
        case .success:
            // Handle successful purchase
            break
        case .failure(let error):
            errorMessage = error
        }
    }
}

enum PurchaseResult {
    case success
    case failure(String)
} 