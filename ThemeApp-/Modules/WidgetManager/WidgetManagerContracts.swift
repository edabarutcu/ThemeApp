//
//  WidgetManagerContracts.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import Foundation
import Combine
import SwiftUI

// MARK: - View Protocol
protocol WidgetManagerViewProtocol: View {
    var presenter: WidgetManagerPresenter { get }
}

// MARK: - Presenter Protocol
protocol WidgetManagerPresenterProtocol: ObservableObject {
    var theme: Theme { get }
    var selectedWidgets: Set<String> { get }
    var availableWidgets: [Widget] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func loadAvailableWidgets()
    func toggleWidget(_ widget: Widget)
    func selectAllWidgets()
    func clearSelection()
    func applyWidgets()
    func previewWidget(_ widget: Widget)
}

// MARK: - Interactor Protocol
protocol WidgetManagerInteractorProtocol {
    var availableWidgetsPublisher: AnyPublisher<[Widget], Never> { get }
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<String?, Never> { get }
    
    func loadAvailableWidgets(for theme: Theme)
    func applyWidgets(_ widgets: [Widget], for theme: Theme)
    func getWidgetConfiguration(for widget: Widget) -> WidgetConfiguration
}

// MARK: - Router Protocol
protocol WidgetManagerRouterProtocol {
    func navigateToWidgetPreview(_ widget: Widget)
    func navigateToWidgetSettings(_ widget: Widget)
} 