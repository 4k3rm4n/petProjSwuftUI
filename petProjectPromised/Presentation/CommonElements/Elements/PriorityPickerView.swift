//
//  PriorityPickerView.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 29.09.2025.
//

import SwiftUI

struct PriorityPickerView: View {
    @Binding var selectedPriority: TaskPriority
    
    var body: some View {
        HStack(spacing: 16) {
            
            ForEach(TaskPriority.allCases, id: \.self) { priority in
                HStack {
                    Circle()
                        .fill(priority.color())
                        .frame(width: 12, height: 12)
                    Text(priority.title())
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(selectedPriority == priority ? Color.gray.opacity(0.4) : Color.clear)
                .cornerRadius(12)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        selectedPriority = priority
                    }
                }
            }
        }
        .padding(8)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(20)
    }
}

#Preview {
    PriorityPickerView(selectedPriority: .constant(.medium))
}
