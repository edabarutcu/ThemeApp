//
//  WidgetManagerView.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import SwiftUI

struct WidgetManagerView: View {
    @ObservedObject var presenter: WidgetManagerPresenter
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Theme info header
                    themeHeader
                    
                    // Available widgets
                    availableWidgetsSection
                    
                    // Widget preview
                    widgetPreviewSection
                    
                    // Action buttons
                    actionSection
                }
                .padding()
            }
            .navigationTitle(L10n.Navigation.widgetManager.localized)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(L10n.Widget.cancel.localized) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(L10n.Theme.apply.localized) {
                        presenter.applyWidgets()
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
    
    private var themeHeader: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 16)
                .fill(presenter.theme.primaryColor)
                .frame(height: 100)
                .overlay(
                    HStack(spacing: 16) {
                        Image(systemName: presenter.theme.iconName)
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(presenter.theme.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("\(presenter.selectedWidgets.count) \(L10n.Widget.widgetSelected.localized)")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        Spacer()
                    }
                    .padding()
                )
        }
    }
    
    private var availableWidgetsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(L10n.Widget.availableWidgets.localized)
                .font(.headline)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                ForEach(presenter.availableWidgets) { widget in
                    WidgetSelectionCard(
                        widget: widget,
                        isSelected: presenter.selectedWidgets.contains(widget.id),
                        themeColor: presenter.theme.primaryColor
                    ) {
                        presenter.toggleWidget(widget)
                    }
                }
            }
        }
    }
    
    private var widgetPreviewSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(L10n.Widget.widgetPreview.localized)
                .font(.headline)
                .fontWeight(.semibold)
            
            if presenter.selectedWidgets.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "rectangle.stack")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    
                    Text(L10n.Widget.noWidgetSelected.localized)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .background(Color(.systemGray6))
                .cornerRadius(12)
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                    ForEach(presenter.availableWidgets.filter { presenter.selectedWidgets.contains($0.id) }) { widget in
                        WidgetPreviewCard(widget: widget, themeColor: presenter.theme.primaryColor)
                    }
                }
            }
        }
    }
    
    private var actionSection: some View {
        VStack(spacing: 12) {
            Button(action: { presenter.selectAllWidgets() }) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                    Text(L10n.Widget.selectAll.localized)
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(presenter.theme.primaryColor)
                .cornerRadius(12)
            }
            
            Button(action: { presenter.clearSelection() }) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                    Text(L10n.Widget.clearSelection.localized)
                }
                .font(.headline)
                .foregroundColor(presenter.theme.primaryColor)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(presenter.theme.primaryColor.opacity(0.1))
                .cornerRadius(12)
            }
        }
    }
}

struct WidgetSelectionCard: View {
    let widget: Widget
    let isSelected: Bool
    let themeColor: Color
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: widget.iconName)
                        .font(.title3)
                        .foregroundColor(widget.color)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.title3)
                    } else {
                        Image(systemName: "circle")
                            .foregroundColor(.gray)
                            .font(.title3)
                    }
                }
                
                Text(widget.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(widget.size.displayName)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Widget preview
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? themeColor.opacity(0.2) : Color(.systemGray5))
                    .frame(height: 40)
                    .overlay(
                        HStack {
                            Image(systemName: widget.iconName)
                                .font(.caption)
                                .foregroundColor(widget.color)
                            Text(widget.type.displayName)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    )
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    WidgetManagerView(presenter: WidgetManagerPresenter(theme: Theme.sampleThemes[0]))
} 