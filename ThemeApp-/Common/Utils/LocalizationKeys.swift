//
//  LocalizationKeys.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import Foundation

// MARK: - Localization Keys Enum
enum L10n {
    
    // MARK: - Navigation Titles
    enum Navigation {
        static let market = "market_title"
        static let purchased = "purchased_title"
        static let profile = "profile_title"
        static let widgetManager = "widget_manager_title"
    }
    
    // MARK: - Authentication
    enum Auth {
        static let signInWithApple = "sign_in_with_apple"
        static let signingIn = "signing_in"
        static let signOut = "sign_out"
        static let signingOut = "signing_out"
        static let signInPrompt = "sign_in_prompt"
        static let signInDescription = "sign_in_description"
        static let appleIdSignedIn = "apple_id_signed_in"
        static let premiumMember = "premium_member"
        static let unknownError = "unknown_error"
        static let ok = "ok"
    }
    
    // MARK: - Loading
    enum Loading {
        static let loading = "loading"
    }
    
    // MARK: - Theme Details
    enum Theme {
        static let premiumTheme = "premium_theme"
        static let themeDescription = "theme_description"
        static let price = "price"
        static let downloads = "downloads"
        static let widgets = "widgets"
        static let manage = "manage"
        static let included = "included"
        static let appIcons = "app_icons"
        static let app = "app"
        static let buy = "buy"
        static let preview = "preview"
        static let purchased = "purchased"
        static let apply = "apply"
    }
    
    // MARK: - Widget Management
    enum Widget {
        static let availableWidgets = "available_widgets"
        static let widgetPreview = "widget_preview"
        static let noWidgetSelected = "no_widget_selected"
        static let widgetSelected = "widget_selected"
        static let selectAll = "select_all"
        static let clearSelection = "clear_selection"
        static let cancel = "cancel"
    }
    
    // MARK: - Purchased Themes
    enum Purchased {
        static let noPurchasedThemes = "no_purchased_themes"
        static let purchasedThemesDescription = "purchased_themes_description"
        static let goToMarket = "go_to_market"
    }
    
    // MARK: - Widget Types
    enum WidgetType {
        static let weather = "weather"
        static let calendar = "calendar"
        static let clock = "clock"
        static let music = "music"
        static let battery = "battery"
        static let activity = "activity"
        static let reminders = "reminders"
        static let photos = "photos"
    }
    
    // MARK: - Widget Sizes
    enum WidgetSize {
        static let small = "small"
        static let medium = "medium"
        static let large = "large"
    }
    
    // MARK: - Tab Bar
    enum Tab {
        static let market = "market_tab"
        static let purchased = "purchased_tab"
        static let profile = "profile_tab"
    }
} 