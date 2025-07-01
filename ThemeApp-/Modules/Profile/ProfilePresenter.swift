//
//  ProfilePresenter.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import SwiftUI
import Combine

@MainActor
class ProfilePresenter: ObservableObject {
    @Published var userProfile: UserProfile
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let interactor: ProfileInteractorProtocol
    private let router: ProfileRouterProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: ProfileInteractorProtocol = ProfileInteractor(), router: ProfileRouterProtocol = ProfileRouter()) {
        self.userProfile = UserProfile(
            id: "",
            name: "",
            email: "",
            isPremium: false,
            purchasedThemes: 0,
            downloadedThemes: 0,
            favoriteThemes: 0,
            joinDate: Date(),
            lastActive: Date()
        )
        self.interactor = interactor
        self.router = router
        setupBindings()
        loadUserProfile()
    }
    
    private func setupBindings() {
        interactor.userProfilePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] profile in
                self?.userProfile = profile
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
    
    func loadUserProfile() {
        interactor.loadUserProfile()
    }
    
    func showPurchasedThemes() {
        router.navigateToPurchasedThemes()
    }
    
    func showAppliedThemes() {
        router.navigateToAppliedThemes()
    }
    
    func showSettings() {
        router.navigateToSettings()
    }
    
    func showHelp() {
        router.navigateToHelp()
    }
    
    func showAbout() {
        router.navigateToAbout()
    }
    
    func logout() {
        interactor.logout()
    }
} 