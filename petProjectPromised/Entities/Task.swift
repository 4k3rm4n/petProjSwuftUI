//
//  Task.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import Foundation

struct Task: Identifiable, Hashable, Codable {
    var id: UUID
    var name: String
    var description: String
    var tillDate: Date?
    var tillTime: Date?
    var status: TaskStatus
    var priority: TaskPriority
    
    init(id: UUID = UUID(), name: String = "", description: String = "", tillDate: Date? = nil, tillTime: Date? = nil, status: TaskStatus = .active, priority: TaskPriority = .medium) {
        self.id = id
        self.name = name
        self.description = description
        self.tillDate = tillDate
        self.tillTime = tillTime
        self.status = status
        self.priority = priority
    }
}

extension Task {
    static var sapmle = Task(name: "Sample task", description: "description", tillDate: Date(), tillTime: Date(), status: .active, priority: .medium)
    static var samplelist: [Task] = [Task(name: "Sample task", description: "description", tillDate: Date(), tillTime: Date(), status: .active, priority: .low),
                                     Task(name: "Sample task", description: "description", tillDate: Date(), tillTime: Date(), status: .active, priority: .medium),
                                     Task(name: "Sample task", description: "description", tillDate: Date(), tillTime: Date(), status: .active, priority: .high)]
}
