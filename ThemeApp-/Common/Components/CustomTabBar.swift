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
            ForEach(0..<TabItem.allCases.count, id: \.self) { index in
                let tab = TabItem.allCases[index]
                TabBarButton(
                    isSelected: selectedTab == index,
                    tab: tab
                ) {
                    selectedTab = index
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
}

enum TabItem: CaseIterable {
    case market
    case purchased
    case profile
    
    var title: String {
        switch self {
        case .market:
            return L10n.Tab.market.localized
        case .purchased:
            return L10n.Tab.purchased.localized
        case .profile:
            return L10n.Tab.profile.localized
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
