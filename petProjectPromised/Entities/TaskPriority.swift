//
//  TaskPriority.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import SwiftUI

enum TaskPriority: Int, Codable {
    case low = 1
    case medium
    case high
    
    func color() -> Color {
        switch self {
        case .low:
            return .blue
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
    
    func title() -> String {
        switch self {
        case .low:
            return "Low priority"
        case .medium:
            return "Medium priority"
        case .high:
            return "High priority"
        }
    }
}
