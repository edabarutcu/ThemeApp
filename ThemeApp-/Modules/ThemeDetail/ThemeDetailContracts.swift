//
//  ThemeDetailContracts.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import Foundation
import Combine
import SwiftUI

// MARK: - View Protocol
protocol ThemeDetailViewProtocol: View {
    var presenter: ThemeDetailPresenter { get }
}

// MARK: - Presenter Protocol
protocol ThemeDetailPresenterProtocol: ObservableObject {
    var theme: Theme { get }
    var isPurchasing: Bool { get }
    var showPreview: Bool { get }
    var errorMessage: String? { get }
    
    func purchaseTheme()
    func previewTheme()
    func applyTheme()
}

// MARK: - Interactor Protocol
protocol ThemeDetailInteractorProtocol {
    var purchaseResultPublisher: AnyPublisher<PurchaseResult, Never> { get }
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<String?, Never> { get }
    
    func purchaseTheme(_ theme: Theme)
    func applyTheme(_ theme: Theme)
    func downloadTheme(_ theme: Theme)
}

// MARK: - Router Protocol
protocol ThemeDetailRouterProtocol {
    func navigateBack()
    func navigateToPurchase(_ theme: Theme)
} 