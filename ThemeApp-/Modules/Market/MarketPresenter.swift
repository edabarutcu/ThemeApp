//
//  MarketPresenter.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import SwiftUI
import Combine

@MainActor
class MarketPresenter: ObservableObject {
    @Published var themes: [Theme] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let interactor: MarketInteractorProtocol
    private let router: MarketRouterProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: MarketInteractorProtocol = MarketInteractor(), router: MarketRouterProtocol = MarketRouter()) {
        self.interactor = interactor
        self.router = router
        setupBindings()
        loadThemes()
    }
    
    private func setupBindings() {
        interactor.themesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] themes in
                self?.themes = themes
            }
            .store(in: &cancellables)
        
        interactor.loadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
            }
            .store(in: &cancellables)
        
        interactor.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.errorMessage = error
            }
            .store(in: &cancellables)
    }
    
    func loadThemes() {
        interactor.loadThemes()
    }
    
    func selectTheme(_ theme: Theme) {
        router.navigateToThemeDetail(theme)
    }
    
    func refreshThemes() {
        loadThemes()
    }
} 