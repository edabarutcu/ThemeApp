//
//  LocalizationHelper.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import Foundation

class LocalizationHelper {
    static let shared = LocalizationHelper()
    
    private init() {}
    
    /// Returns the current locale based on device region
    var currentLocale: Locale {
        let deviceLocale = Locale.current
        let regionCode = deviceLocale.region?.identifier ?? "US"
        
        // If region is Turkey, use Turkish, otherwise use English
        if regionCode == "TR" {
            return Locale(identifier: "tr")
        } else {
            return Locale(identifier: "en")
        }
    }
    
    /// Returns the current language code
    var currentLanguageCode: String {
        return currentLocale.language.languageCode?.identifier ?? "en"
    }
    
    /// Returns the current region code
    var currentRegionCode: String {
        return currentLocale.region?.identifier ?? "US"
    }
    
    /// Localized string for the given key
    func localizedString(for key: String) -> String {
        let bundle = Bundle.main
        let languageCode = currentLanguageCode
        
        // Try to get the localized string from the appropriate bundle
        if let path = bundle.path(forResource: languageCode, ofType: "lproj"),
           let languageBundle = Bundle(path: path) {
            return languageBundle.localizedString(forKey: key, value: key, table: "Localizable")
        }
        
        // Fallback to main bundle
        return bundle.localizedString(forKey: key, value: key, table: "Localizable")
    }
    
    /// Localized string with format arguments
    func localizedString(for key: String, arguments: CVarArg...) -> String {
        let format = localizedString(for: key)
        return String(format: format, arguments: arguments)
    }
}

// MARK: - String Extension for easier localization
extension String {
    var localized: String {
        return LocalizationHelper.shared.localizedString(for: self)
    }
    
    func localized(with arguments: CVarArg...) -> String {
        return LocalizationHelper.shared.localizedString(for: self, arguments: arguments)
    }
} 