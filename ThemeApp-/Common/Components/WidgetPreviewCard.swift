//
//  WidgetPreviewCard.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 21.06.2025.
//

import SwiftUI

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
            
            RoundedRectangle(cornerRadius: 8)
                .fill(widget.isIncluded ? themeColor.opacity(0.2) : Color(.systemGray5))
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
