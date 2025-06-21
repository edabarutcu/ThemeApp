//
//  ThemeDetailView.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import SwiftUI

struct ThemeDetailView: View {
    @ObservedObject var presenter: ThemeDetailPresenter
    @Environment(\.dismiss) private var dismiss
    @State private var showingWidgetManager = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header with theme preview
                headerSection
                
                // Theme information
                infoSection
                
                // Widgets section
                widgetsSection
                
                // Preview section
                previewSection
                
                // Action buttons
                actionSection
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
            }
        }
        .sheet(isPresented: $showingWidgetManager) {
            WidgetManagerView(presenter: WidgetManagerPresenter(theme: presenter.theme))
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 20)
                .fill(presenter.theme.primaryColor)
                .frame(height: 200)
                .overlay(
                    VStack(spacing: 12) {
                        Image(systemName: presenter.theme.iconName)
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        
                        Text(presenter.theme.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                )
            
            if presenter.theme.isPremium {
                HStack {
                    Image(systemName: "crown.fill")
                        .foregroundColor(.yellow)
                    Text("Premium Tema")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tema Açıklaması")
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(presenter.theme.description)
                .font(.body)
                .foregroundColor(.secondary)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Fiyat")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("₺\(presenter.theme.price, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("İndirme")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("1.2K")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    private var widgetsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Widget'lar")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Yönet") {
                    showingWidgetManager = true
                }
                .font(.subheadline)
                .foregroundColor(presenter.theme.primaryColor)
            }
            
            Text("\(presenter.theme.widgets.filter { $0.isIncluded }.count) dahil")
                .font(.caption)
                .foregroundColor(.secondary)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                ForEach(presenter.theme.widgets) { widget in
                    WidgetPreviewCard(widget: widget, themeColor: presenter.theme.primaryColor)
                }
            }
        }
    }
    
    private var previewSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Uygulama İkonları")
                .font(.headline)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(presenter.theme.appIcons, id: \.self) { iconName in
                        VStack(spacing: 8) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(presenter.theme.primaryColor)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "app.fill")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                )
                            
                            Text("Uygulama")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var actionSection: some View {
        VStack(spacing: 12) {
            Button(action: { presenter.purchaseTheme() }) {
                HStack {
                    Image(systemName: "cart.fill")
                    Text("Satın Al")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(presenter.theme.primaryColor)
                .cornerRadius(12)
            }
            
            Button(action: { presenter.previewTheme() }) {
                HStack {
                    Image(systemName: "eye.fill")
                    Text("Önizle")
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

struct WidgetPreviewCard: View {
    let widget: Widget
    let themeColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: widget.iconName)
                    .font(.title3)
                    .foregroundColor(widget.color)
                
                Spacer()
                
                if widget.isIncluded {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.caption)
                } else {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.blue)
                        .font(.caption)
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
                .fill(themeColor.opacity(0.1))
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
}

#Preview {
    NavigationView {
        ThemeDetailView(presenter: ThemeDetailPresenter(theme: Theme.mockTheme))
    }
} 