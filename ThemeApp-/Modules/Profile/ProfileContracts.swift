//
//  ProfileContracts.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import Foundation
import Combine
import SwiftUI

// MARK: - View Protocol
protocol ProfileViewProtocol: View {
    var presenter: ProfilePresenter { get }
}

// MARK: - Presenter Protocol
protocol ProfilePresenterProtocol: ObservableObject {
    var userProfile: UserProfile { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func loadUserProfile()
    func showPurchasedThemes()
    func showAppliedThemes()
    func showSettings()
    func showHelp()
    func showAbout()
    func logout()
}

// MARK: - Interactor Protocol
protocol ProfileInteractorProtocol {
    var userProfilePublisher: AnyPublisher<UserProfile, Never> { get }
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<String?, Never> { get }
    
    func loadUserProfile()
    func logout()
    func updateUserProfile(_ profile: UserProfile)
}

// MARK: - Router Protocol
protocol ProfileRouterProtocol {
    func navigateToPurchasedThemes()
    func navigateToAppliedThemes()
    func navigateToSettings()
    func navigateToHelp()
    func navigateToAbout()
} 