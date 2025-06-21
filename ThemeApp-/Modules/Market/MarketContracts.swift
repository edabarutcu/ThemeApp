//
//  MarketContracts.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import Foundation
import Combine
import SwiftUI

// MARK: - View Protocol
protocol MarketViewProtocol: View {
    var presenter: MarketPresenter { get }
}

// MARK: - Presenter Protocol
protocol MarketPresenterProtocol: ObservableObject {
    var themes: [Theme] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func loadThemes()
    func selectTheme(_ theme: Theme)
    func refreshThemes()
}

// MARK: - Interactor Protocol
protocol MarketInteractorProtocol {
    var themesPublisher: AnyPublisher<[Theme], Never> { get }
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<String?, Never> { get }
    
    func loadThemes()
}

// MARK: - Router Protocol
protocol MarketRouterProtocol {
    func navigateToThemeDetail(_ theme: Theme)
} 