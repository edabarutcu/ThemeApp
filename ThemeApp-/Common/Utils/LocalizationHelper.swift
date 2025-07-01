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
    
    var currentLocale: Locale {
        let deviceLocale = Locale.current
        let regionCode = deviceLocale.region?.identifier ?? "US"
        
        if regionCode == "TR" {
            return Locale(identifier: "tr")
        } else {
            return Locale(identifier: "en")
        }
    }
    
    var currentLanguageCode: String {
        return currentLocale.language.languageCode?.identifier ?? "en"
    }
    
    var currentRegionCode: String {
        return currentLocale.region?.identifier ?? "US"
    }
    
    func localizedString(for key: String) -> String {
        let bundle = Bundle.main
        let languageCode = currentLanguageCode
        
        if let path = bundle.path(forResource: languageCode, ofType: "lproj"),
           let languageBundle = Bundle(path: path) {
            return languageBundle.localizedString(forKey: key, value: key, table: "Localizable")
        }
        
        return bundle.localizedString(forKey: key, value: key, table: "Localizable")
    }
    
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
