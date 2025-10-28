//
//  TaskStatus.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import Foundation

enum TaskStatus: String, Codable { // HomeScreenViewModelImpl
    case active = "Active"
    case overdue = "Overdue"
    case completed = "Completed"
}
