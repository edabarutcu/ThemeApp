//
//  WidgetManagerPresenter.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import SwiftUI
import Combine

@MainActor
class WidgetManagerPresenter: ObservableObject {
    @Published var theme: Theme
    @Published var selectedWidgets: Set<String> = []
    @Published var availableWidgets: [Widget] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let interactor: WidgetManagerInteractorProtocol
    private let router: WidgetManagerRouterProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(theme: Theme, interactor: WidgetManagerInteractorProtocol = WidgetManagerInteractor(), router: WidgetManagerRouterProtocol = WidgetManagerRouter()) {
        self.theme = theme
        self.interactor = interactor
        self.router = router
        setupBindings()
        loadAvailableWidgets()
    }
    
    private func setupBindings() {
        interactor.availableWidgetsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] widgets in
                self?.availableWidgets = widgets
            }
            .store(in: &cancellables)
        
        interactor.loadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
            }
            .store(in: &cancellables)
        
        interactor.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.errorMessage = error
            }
            .store(in: &cancellables)
    }
    
    func loadAvailableWidgets() {
        interactor.loadAvailableWidgets(for: theme)
    }
    
    func toggleWidget(_ widget: Widget) {
        if selectedWidgets.contains(widget.id) {
            selectedWidgets.remove(widget.id)
        } else {
            selectedWidgets.insert(widget.id)
        }
    }
    
    func selectAllWidgets() {
        selectedWidgets = Set(availableWidgets.map { $0.id })
    }
    
    func clearSelection() {
        selectedWidgets.removeAll()
    }
    
    func applyWidgets() {
        let selectedWidgetList = availableWidgets.filter { selectedWidgets.contains($0.id) }
        interactor.applyWidgets(selectedWidgetList, for: theme)
    }
    
    func previewWidget(_ widget: Widget) {
        router.navigateToWidgetPreview(widget)
    }
} 