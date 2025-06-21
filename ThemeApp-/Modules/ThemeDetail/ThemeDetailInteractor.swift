//
//  ThemeDetailInteractor.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import Foundation
import Combine

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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.loadingSubject.send(false)
            
            let isSuccess = Bool.random()
            if isSuccess {
                self?.purchaseResultSubject.send(.success)
            } else {
                self?.purchaseResultSubject.send(.failure("Satın alma işlemi başarısız oldu. Lütfen tekrar deneyin."))
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
