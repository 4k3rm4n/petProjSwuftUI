//
//  Task.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import Foundation

struct Task: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var tillDate: Date
    var status: TaskStatus
    var priority: TaskPriority
}

extension Task {
    static var sapmle = Task(name: "Sample task", tillDate: Date(), status: .active, priority: .medium)
    static var samplelist: [Task] = [Task(name: "Sample task", tillDate: Date(), status: .active, priority: .low), Task(name: "Sample task", tillDate: Date(), status: .active, priority: .medium), Task(name: "Sample task", tillDate: Date(), status: .active, priority: .high)]
}
