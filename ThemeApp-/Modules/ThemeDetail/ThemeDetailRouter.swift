//
//  ThemeDetailRouter.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import SwiftUI

class ThemeDetailRouter: ThemeDetailRouterProtocol {
    func navigateBack() {
        // Navigation back will be handled by SwiftUI's dismiss
    }
    
    func navigateToPurchase(_ theme: Theme) {
        // Navigate to purchase flow
        NotificationCenter.default.post(
            name: .navigateToPurchase,
            object: theme
        )
    }
}

extension Notification.Name {
    static let navigateToPurchase = Notification.Name("navigateToPurchase")
} 