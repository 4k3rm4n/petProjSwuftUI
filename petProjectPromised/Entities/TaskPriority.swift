//
//  TaskPriority.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import SwiftUI
import RealmSwift

enum TaskPriority: Int, PersistableEnum, CaseIterable, Hashable {
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
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
}
