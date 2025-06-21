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
    private let purchaseResultSubject = CurrentValueSubject<PurchaseResult, Never>(.failure(""))
    
    var availableWidgetsPublisher: AnyPublisher<[Widget], Never> {
        availableWidgetsSubject.eraseToAnyPublisher()
    }
    
    var loadingPublisher: AnyPublisher<Bool, Never> {
        loadingSubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String?, Never> {
        errorSubject.eraseToAnyPublisher()
    }
    
    var purchaseResultPublisher: AnyPublisher<PurchaseResult, Never> {
        purchaseResultSubject.eraseToAnyPublisher()
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
        
        // Simulate applying widgets
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.loadingSubject.send(false)
            self?.purchaseResultSubject.send(.success)
        }
    }
    
    private func applyWidget(_ widget: Widget, for theme: Theme) {
        // Simulate individual widget application
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Widget applied successfully
        }
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