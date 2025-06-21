//
//  WidgetManagerRouter.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import SwiftUI

class WidgetManagerRouter: WidgetManagerRouterProtocol {
    func navigateToWidgetPreview(_ widget: Widget) {
        NotificationCenter.default.post(
            name: .navigateToWidgetPreview,
            object: widget
        )
    }
    
    func navigateToWidgetSettings(_ widget: Widget) {
        NotificationCenter.default.post(
            name: .navigateToWidgetSettings,
            object: widget
        )
    }
}

extension Notification.Name {
    static let navigateToWidgetPreview = Notification.Name("navigateToWidgetPreview")
    static let navigateToWidgetSettings = Notification.Name("navigateToWidgetSettings")
} 