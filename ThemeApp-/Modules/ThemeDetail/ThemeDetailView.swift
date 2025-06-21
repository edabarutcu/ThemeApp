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
                    Text(L10n.Theme.premiumTheme.localized)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(L10n.Theme.themeDescription.localized)
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(presenter.theme.description)
                .font(.body)
                .foregroundColor(.secondary)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(L10n.Theme.price.localized)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("₺\(presenter.theme.price, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(L10n.Theme.downloads.localized)
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
                Text(L10n.Theme.widgets.localized)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(L10n.Theme.manage.localized) {
                    showingWidgetManager = true
                }
                .font(.subheadline)
                .foregroundColor(presenter.theme.primaryColor)
            }
            
            Text("\(presenter.theme.widgets.filter { $0.isIncluded }.count) \(L10n.Theme.included.localized)")
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
        VStack(alignment: .leading, spacing: 16) {
            Text(L10n.Theme.appIcons.localized)
                .font(.headline)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                ForEach(0..<8, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(presenter.theme.primaryColor.opacity(0.3))
                        .frame(height: 60)
                        .overlay(
                            Text(L10n.Theme.app.localized)
                                .font(.caption)
                                .foregroundColor(presenter.theme.primaryColor)
                        )
                }
            }
        }
    }
    
    private var actionSection: some View {
        VStack(spacing: 12) {
            Button(action: { presenter.purchaseTheme() }) {
                HStack {
                    Image(systemName: "cart.fill")
                    Text(L10n.Theme.buy.localized)
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
                    Text(L10n.Theme.preview.localized)
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

#Preview {
    NavigationView {
        ThemeDetailView(presenter: ThemeDetailPresenter(theme: Theme.sampleThemes[0]))
    }
} 