//
//  MarketRouter.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import SwiftUI

class MarketRouter: MarketRouterProtocol {
    func navigateToThemeDetail(_ theme: Theme) {
        NotificationCenter.default.post(
            name: .navigateToThemeDetail,
            object: theme
        )
    }
}

extension Notification.Name {
    static let navigateToThemeDetail = Notification.Name("navigateToThemeDetail")
} 
