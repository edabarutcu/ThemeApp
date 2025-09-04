//
//  ThemeDetailInteractor.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import Foundation
import Combine
import StoreKit

class ThemeDetailInteractor: ThemeDetailInteractorProtocol {
    private let purchaseResultSubject = PassthroughSubject<PurchaseResult, Never>()
    private let loadingSubject = CurrentValueSubject<Bool, Never>(false)
    private let errorSubject = CurrentValueSubject<String?, Never>(nil)
    
    var purchaseResultPublisher: AnyPublisher<PurchaseResult, Never> {
        purchaseResultSubject.eraseToAnyPublisher()
    }
    
    var loadingPublisher: AnyPublisher<Bool, Never> {
        loadingSubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String?, Never> {
        errorSubject.eraseToAnyPublisher()
    }
    
    func purchaseTheme(_ theme: Theme) {
        loadingSubject.send(true)
        errorSubject.send(nil)
        
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let productId = self.productIdentifier(for: theme)
                try await StoreKitManager.shared.purchase(productId: productId)
                self.loadingSubject.send(false)
                self.purchaseResultSubject.send(.success)
            } catch {
                self.loadingSubject.send(false)
                let message = (error as? LocalizedError)?.errorDescription ?? "Satın alma işlemi başarısız oldu. Lütfen tekrar deneyin."
                self.errorSubject.send(message)
                self.purchaseResultSubject.send(.failure(message))
            }
        }
    }
    
    func applyTheme(_ theme: Theme) {
        loadingSubject.send(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.loadingSubject.send(false)
            self?.purchaseResultSubject.send(.success)
        }
    }
    
    func downloadTheme(_ theme: Theme) {
        loadingSubject.send(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.loadingSubject.send(false)
            self?.purchaseResultSubject.send(.success)
        }
    }
} 

private extension ThemeDetailInteractor {
    func productIdentifier(for theme: Theme) -> String {
        // Mapping rule between theme id and App Store Connect product id
        // For now, assume product ids are like: com.yourcompany.themeapp.theme.<themeId>
        return "com.yourcompany.themeapp.theme.\(theme.id)"
    }
}
