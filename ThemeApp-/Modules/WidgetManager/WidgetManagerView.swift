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
            .navigationTitle("Widget Yönetimi")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Uygula") {
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
                            
                            Text("\(presenter.selectedWidgets.count) widget seçildi")
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
            Text("Mevcut Widget'lar")
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
            Text("Widget Önizleme")
                .font(.headline)
                .fontWeight(.semibold)
            
            if presenter.selectedWidgets.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "rectangle.stack")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    
                    Text("Henüz widget seçilmedi")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(Color(.systemGray6))
                .cornerRadius(12)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(Array(presenter.selectedWidgets), id: \.self) { widgetId in
                            if let widget = presenter.availableWidgets.first(where: { $0.id == widgetId }) {
                                WidgetPreview(widget: widget, themeColor: presenter.theme.primaryColor)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    private var actionSection: some View {
        VStack(spacing: 12) {
            Button(action: { presenter.selectAllWidgets() }) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Tümünü Seç")
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
                    Text("Seçimi Temizle")
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
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? themeColor : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct WidgetPreview: View {
    let widget: Widget
    let themeColor: Color
    
    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(themeColor.opacity(0.1))
                .frame(width: widget.size.dimensions.width / 3, height: widget.size.dimensions.height / 3)
                .overlay(
                    VStack(spacing: 4) {
                        Image(systemName: widget.iconName)
                            .font(.caption)
                            .foregroundColor(widget.color)
                        Text(widget.name)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                )
            
            Text(widget.size.displayName)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    WidgetManagerView(presenter: WidgetManagerPresenter(theme: Theme.mockTheme))
} 