//
//  ProfileRouter.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import SwiftUI

class ProfileRouter: ProfileRouterProtocol {
    func navigateToPurchasedThemes() {
        NotificationCenter.default.post(
            name: .navigateToPurchasedThemes,
            object: nil
        )
    }
    
    func navigateToAppliedThemes() {
        NotificationCenter.default.post(
            name: .navigateToAppliedThemes,
            object: nil
        )
    }
    
    func navigateToSettings() {
        NotificationCenter.default.post(
            name: .navigateToSettings,
            object: nil
        )
    }
    
    func navigateToHelp() {
        NotificationCenter.default.post(
            name: .navigateToHelp,
            object: nil
        )
    }
    
    func navigateToAbout() {
        NotificationCenter.default.post(
            name: .navigateToAbout,
            object: nil
        )
    }
}

extension Notification.Name {
    static let navigateToPurchasedThemes = Notification.Name("navigateToPurchasedThemes")
    static let navigateToAppliedThemes = Notification.Name("navigateToAppliedThemes")
    static let navigateToSettings = Notification.Name("navigateToSettings")
    static let navigateToHelp = Notification.Name("navigateToHelp")
    static let navigateToAbout = Notification.Name("navigateToAbout")
} 