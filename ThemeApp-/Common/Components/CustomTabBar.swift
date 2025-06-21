//
//  CustomTabBar.swift
//  ThemeApp
//
//  Created by Eda Barutçu on 20.06.2025.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<3) { index in
                TabBarButton(
                    isSelected: selectedTab == index,
                    tab: TabItem.allCases[index]
                ) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = index
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal, 20)
    }
}

struct TabBarButton: View {
    let isSelected: Bool
    let tab: TabItem
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? tab.selectedIcon : tab.icon)
                    .font(.system(size: 20, weight: isSelected ? .semibold : .medium))
                    .foregroundColor(isSelected ? tab.color : .gray)
                    .scaleEffect(isSelected ? 1.2 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
                
                Text(tab.title)
                    .font(.caption2)
                    .fontWeight(isSelected ? .semibold : .medium)
                    .foregroundColor(isSelected ? tab.color : .gray)
                    .opacity(isSelected ? 1.0 : 0.7)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(isSelected ? tab.color.opacity(0.15) : Color.clear)
                    .scaleEffect(isSelected ? 1.0 : 0.8)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

enum TabItem: CaseIterable {
    case market
    case purchased
    case profile
    
    var title: String {
        switch self {
        case .market:
            return "Market"
        case .purchased:
            return "Satın Aldıklarım"
        case .profile:
            return "Profil"
        }
    }
    
    var icon: String {
        switch self {
        case .market:
            return "storefront"
        case .purchased:
            return "bag"
        case .profile:
            return "person"
        }
    }
    
    var selectedIcon: String {
        switch self {
        case .market:
            return "storefront.fill"
        case .purchased:
            return "bag.fill"
        case .profile:
            return "person.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .market:
            return .blue
        case .purchased:
            return .green
        case .profile:
            return .purple
        }
    }
}

#Preview {
    VStack {
        Spacer()
        CustomTabBar(selectedTab: .constant(0))
    }
    .background(Color(.systemBackground))
} 