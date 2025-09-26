//
//  MainScreenHeaderView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 26.09.2025.
//

import SwiftUI

struct MainScreenHeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Prioritize")
                    .font(.system(size: 24, weight: .semibold))
                
                Text("Best platform for creating to-do lists")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "gearshape.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    MainScreenHeaderView()
}
