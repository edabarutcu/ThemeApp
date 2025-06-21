//
//  WidgetManagerInteractor.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import Foundation
import Combine

class WidgetManagerInteractor: WidgetManagerInteractorProtocol {
    private let availableWidgetsSubject = CurrentValueSubject<[Widget], Never>([])
    private let loadingSubject = CurrentValueSubject<Bool, Never>(false)
    private let errorSubject = CurrentValueSubject<String?, Never>(nil)
    
    var availableWidgetsPublisher: AnyPublisher<[Widget], Never> {
        availableWidgetsSubject.eraseToAnyPublisher()
    }
    
    var loadingPublisher: AnyPublisher<Bool, Never> {
        loadingSubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String?, Never> {
        errorSubject.eraseToAnyPublisher()
    }
    
    func loadAvailableWidgets(for theme: Theme) {
        loadingSubject.send(true)
        errorSubject.send(nil)
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.loadingSubject.send(false)
            self?.availableWidgetsSubject.send(theme.widgets)
        }
    }
    
    func applyWidgets(_ widgets: [Widget], for theme: Theme) {
        loadingSubject.send(true)
        errorSubject.send(nil)
        
        // Simulate applying widgets
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.loadingSubject.send(false)
            
            // Apply widgets to device
            print("Applying \(widgets.count) widgets for theme: \(theme.name)")
            
            // Here you would integrate with iOS WidgetKit to actually apply the widgets
            for widget in widgets {
                self?.applyWidgetToDevice(widget, theme: theme)
            }
        }
    }
    
    private func applyWidgetToDevice(_ widget: Widget, theme: Theme) {
        // This would integrate with iOS WidgetKit APIs
        // For now, just print the action
        print("Applying widget: \(widget.name) (\(widget.type.displayName)) - Size: \(widget.size.displayName)")
        print("Theme colors: Primary: \(theme.primaryColor), Secondary: \(theme.secondaryColor)")
    }
    
    func getWidgetConfiguration(for widget: Widget) -> WidgetConfiguration {
        // Return widget configuration based on type
        switch widget.type {
        case .weather:
            return WidgetConfiguration(
                type: .weather,
                refreshInterval: 1800, // 30 minutes
                requiresLocation: true,
                customColors: true
            )
        case .calendar:
            return WidgetConfiguration(
                type: .calendar,
                refreshInterval: 3600, // 1 hour
                requiresLocation: false,
                customColors: true
            )
        case .clock:
            return WidgetConfiguration(
                type: .clock,
                refreshInterval: 60, // 1 minute
                requiresLocation: false,
                customColors: true
            )
        case .music:
            return WidgetConfiguration(
                type: .music,
                refreshInterval: 300, // 5 minutes
                requiresLocation: false,
                customColors: true
            )
        case .battery:
            return WidgetConfiguration(
                type: .battery,
                refreshInterval: 300, // 5 minutes
                requiresLocation: false,
                customColors: true
            )
        case .activity:
            return WidgetConfiguration(
                type: .activity,
                refreshInterval: 1800, // 30 minutes
                requiresLocation: true,
                customColors: true
            )
        case .reminders:
            return WidgetConfiguration(
                type: .reminders,
                refreshInterval: 600, // 10 minutes
                requiresLocation: false,
                customColors: true
            )
        case .photos:
            return WidgetConfiguration(
                type: .photos,
                refreshInterval: 3600, // 1 hour
                requiresLocation: false,
                customColors: true
            )
        }
    }
}

struct WidgetConfiguration {
    let type: WidgetType
    let refreshInterval: TimeInterval
    let requiresLocation: Bool
    let customColors: Bool
} 