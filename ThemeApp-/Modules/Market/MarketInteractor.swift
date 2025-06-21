//
//  MarketInteractor.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import Foundation
import Combine

class MarketInteractor: MarketInteractorProtocol {
    private let themesSubject = CurrentValueSubject<[Theme], Never>([])
    private let loadingSubject = CurrentValueSubject<Bool, Never>(false)
    private let errorSubject = CurrentValueSubject<String?, Never>(nil)
    
    var themesPublisher: AnyPublisher<[Theme], Never> {
        themesSubject.eraseToAnyPublisher()
    }
    
    var loadingPublisher: AnyPublisher<Bool, Never> {
        loadingSubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String?, Never> {
        errorSubject.eraseToAnyPublisher()
    }
    
    func loadThemes() {
        loadingSubject.send(true)
        errorSubject.send(nil)
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.loadingSubject.send(false)
            self?.themesSubject.send(self?.getMockThemes() ?? [])
        }
    }
    
    private func getMockThemes() -> [Theme] {
        return [
            Theme(
                id: "1",
                name: "Neon Dreams",
                description: "Parlak neon renklerle modern görünüm",
                price: 9.99,
                isPremium: true,
                primaryColor: .purple,
                secondaryColor: .pink,
                iconName: "sparkles",
                wallpaperURL: "neon_dreams_wallpaper",
                appIcons: ["neon_icon_1", "neon_icon_2", "neon_icon_3"],
                widgets: [
                    Widget(id: "1", name: "Neon Hava", type: .weather, size: .medium, isIncluded: true),
                    Widget(id: "2", name: "Neon Saat", type: .clock, size: .small, isIncluded: true),
                    Widget(id: "3", name: "Neon Müzik", type: .music, size: .medium, isIncluded: true),
                    Widget(id: "4", name: "Neon Takvim", type: .calendar, size: .large, isIncluded: false)
                ]
            ),
            Theme(
                id: "2",
                name: "Ocean Waves",
                description: "Sakinleştirici mavi tonlar",
                price: 4.99,
                isPremium: false,
                primaryColor: .blue,
                secondaryColor: .cyan,
                iconName: "water.waves",
                wallpaperURL: "ocean_waves_wallpaper",
                appIcons: ["ocean_icon_1", "ocean_icon_2", "ocean_icon_3"],
                widgets: [
                    Widget(id: "5", name: "Okyanus Hava", type: .weather, size: .medium, isIncluded: true),
                    Widget(id: "6", name: "Okyanus Saat", type: .clock, size: .small, isIncluded: true),
                    Widget(id: "7", name: "Okyanus Pil", type: .battery, size: .small, isIncluded: false)
                ]
            ),
            Theme(
                id: "3",
                name: "Forest Green",
                description: "Doğal yeşil tonlar",
                price: 6.99,
                isPremium: false,
                primaryColor: .green,
                secondaryColor: .mint,
                iconName: "leaf.fill",
                wallpaperURL: "forest_green_wallpaper",
                appIcons: ["forest_icon_1", "forest_icon_2", "forest_icon_3"],
                widgets: [
                    Widget(id: "8", name: "Orman Hava", type: .weather, size: .medium, isIncluded: true),
                    Widget(id: "9", name: "Orman Aktivite", type: .activity, size: .medium, isIncluded: true),
                    Widget(id: "10", name: "Orman Hatırlatıcı", type: .reminders, size: .small, isIncluded: false)
                ]
            ),
            Theme(
                id: "4",
                name: "Sunset Glow",
                description: "Sıcak turuncu ve sarı tonlar",
                price: 7.99,
                isPremium: true,
                primaryColor: .orange,
                secondaryColor: .yellow,
                iconName: "sun.max.fill",
                wallpaperURL: "sunset_glow_wallpaper",
                appIcons: ["sunset_icon_1", "sunset_icon_2", "sunset_icon_3"],
                widgets: [
                    Widget(id: "11", name: "Gün Batımı Hava", type: .weather, size: .medium, isIncluded: true),
                    Widget(id: "12", name: "Gün Batımı Saat", type: .clock, size: .small, isIncluded: true),
                    Widget(id: "13", name: "Gün Batımı Takvim", type: .calendar, size: .large, isIncluded: true),
                    Widget(id: "14", name: "Gün Batımı Fotoğraf", type: .photos, size: .medium, isIncluded: false)
                ]
            ),
            Theme(
                id: "5",
                name: "Midnight Dark",
                description: "Koyu tema seçenekleri",
                price: 5.99,
                isPremium: false,
                primaryColor: .black,
                secondaryColor: .gray,
                iconName: "moon.fill",
                wallpaperURL: "midnight_dark_wallpaper",
                appIcons: ["midnight_icon_1", "midnight_icon_2", "midnight_icon_3"],
                widgets: [
                    Widget(id: "15", name: "Gece Hava", type: .weather, size: .medium, isIncluded: true),
                    Widget(id: "16", name: "Gece Saat", type: .clock, size: .small, isIncluded: true),
                    Widget(id: "17", name: "Gece Pil", type: .battery, size: .small, isIncluded: true)
                ]
            ),
            Theme(
                id: "6",
                name: "Rose Gold",
                description: "Zarif pembe ve altın tonlar",
                price: 12.99,
                isPremium: true,
                primaryColor: .pink,
                secondaryColor: .orange,
                iconName: "heart.fill",
                wallpaperURL: "rose_gold_wallpaper",
                appIcons: ["rose_icon_1", "rose_icon_2", "rose_icon_3"],
                widgets: [
                    Widget(id: "18", name: "Rose Hava", type: .weather, size: .medium, isIncluded: true),
                    Widget(id: "19", name: "Rose Saat", type: .clock, size: .small, isIncluded: true),
                    Widget(id: "20", name: "Rose Takvim", type: .calendar, size: .large, isIncluded: true),
                    Widget(id: "21", name: "Rose Müzik", type: .music, size: .medium, isIncluded: true),
                    Widget(id: "22", name: "Rose Fotoğraf", type: .photos, size: .medium, isIncluded: false)
                ]
            )
        ]
    }
} 