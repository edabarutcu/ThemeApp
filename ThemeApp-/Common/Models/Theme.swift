//
//  Theme.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//


import SwiftUI

struct Theme: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let isPremium: Bool
    let primaryColor: Color
    let secondaryColor: Color
    let iconName: String
    let wallpaperURL: String
    let appIcons: [String]
    let widgets: [Widget]
    
    static let mockTheme = Theme(
        id: "mock",
        name: "Mock Theme",
        description: "This is a mock theme for preview purposes",
        price: 9.99,
        isPremium: true,
        primaryColor: .purple,
        secondaryColor: .pink,
        iconName: "sparkles",
        wallpaperURL: "mock_wallpaper",
        appIcons: ["mock_icon_1", "mock_icon_2", "mock_icon_3"],
        widgets: [
            Widget(id: "1", name: "Hava Durumu", type: .weather, size: .medium, isIncluded: true),
            Widget(id: "2", name: "Takvim", type: .calendar, size: .large, isIncluded: true),
            Widget(id: "3", name: "Saat", type: .clock, size: .small, isIncluded: true),
            Widget(id: "4", name: "Müzik", type: .music, size: .medium, isIncluded: false)
        ]
    )
    
    static let sampleThemes: [Theme] = [mockTheme]
}

struct Widget: Identifiable, Codable {
    let id: String
    let name: String
    let type: WidgetType
    let size: WidgetSize
    let isIncluded: Bool
    
    var iconName: String {
        switch type {
        case .weather:
            return "cloud.sun.fill"
        case .calendar:
            return "calendar"
        case .clock:
            return "clock.fill"
        case .music:
            return "music.note"
        case .battery:
            return "battery.100"
        case .activity:
            return "figure.walk"
        case .reminders:
            return "checklist"
        case .photos:
            return "photo.fill"
        }
    }
    
    var color: Color {
        switch type {
        case .weather:
            return .blue
        case .calendar:
            return .red
        case .clock:
            return .orange
        case .music:
            return .pink
        case .battery:
            return .green
        case .activity:
            return .purple
        case .reminders:
            return .yellow
        case .photos:
            return .cyan
        }
    }
}

enum WidgetType: String, CaseIterable, Codable {
    case weather = "weather"
    case calendar = "calendar"
    case clock = "clock"
    case music = "music"
    case battery = "battery"
    case activity = "activity"
    case reminders = "reminders"
    case photos = "photos"
    
    var displayName: String {
        switch self {
        case .weather:
            return L10n.WidgetType.weather.localized
        case .calendar:
            return L10n.WidgetType.calendar.localized
        case .clock:
            return L10n.WidgetType.clock.localized
        case .music:
            return L10n.WidgetType.music.localized
        case .battery:
            return L10n.WidgetType.battery.localized
        case .activity:
            return L10n.WidgetType.activity.localized
        case .reminders:
            return L10n.WidgetType.reminders.localized
        case .photos:
            return L10n.WidgetType.photos.localized
        }
    }
}

enum WidgetSize: String, CaseIterable, Codable {
    case small = "small"
    case medium = "medium"
    case large = "large"
    
    var displayName: String {
        switch self {
        case .small:
            return L10n.WidgetSize.small.localized
        case .medium:
            return L10n.WidgetSize.medium.localized
        case .large:
            return L10n.WidgetSize.large.localized
        }
    }
    
    var dimensions: (width: CGFloat, height: CGFloat) {
        switch self {
        case .small:
            return (155, 155)
        case .medium:
            return (329, 155)
        case .large:
            return (329, 345)
        }
    }
}

// MARK: - Color Codable Extension
extension Color: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hex = try container.decode(String.self)
        self.init(hex: hex)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(toHex())
    }
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    func toHex() -> String {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return "000000"
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if a != Float(1.0) {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
} 
