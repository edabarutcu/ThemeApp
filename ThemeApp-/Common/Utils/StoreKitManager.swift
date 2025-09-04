//
//  StoreKitManager.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 04.09.2025.
//

import Foundation
import StoreKit

@MainActor
final class StoreKitManager: ObservableObject {
    static let shared = StoreKitManager()
    
    private init() {}
    
    func product(for productId: String) async throws -> Product {
        let products = try await Product.products(for: [productId])
        guard let product = products.first else {
            throw StoreKitError.productNotFound
        }
        return product
    }
    
    func purchase(productId: String) async throws {
        let product = try await product(for: productId)
        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            let transaction = try Self.verify(verification)
            await transaction.finish()
        case .userCancelled:
            throw StoreKitError.userCancelled
        case .pending:
            throw StoreKitError.pending
        @unknown default:
            throw StoreKitError.unknown
        }
    }
    
    func restorePurchases() async throws {
        try await AppStore.sync()
        for await result in Transaction.currentEntitlements {
            do {
                _ = try Self.verify(result)
            } catch {
                // Ignore unverifiable entitlements during restore sync
            }
        }
    }
    
    private static func verify<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreKitError.unverified
        case .verified(let transaction):
            return transaction
        }
    }
}

enum StoreKitError: LocalizedError {
    case productNotFound
    case userCancelled
    case pending
    case unverified
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .productNotFound:
            return "Ürün bulunamadı."
        case .userCancelled:
            return "Satın alma iptal edildi."
        case .pending:
            return "Satın alma beklemede."
        case .unverified:
            return "Satın alma doğrulanamadı."
        case .unknown:
            return "Bilinmeyen bir hata oluştu."
        }
    }
}


