//
//  RoundedTaskViewModelImpl.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import Foundation

class RoundedTaskViewModelImpl: RoundedTaskViewModel {
    
    @Published var taskName: String
    @Published var taskPriority: TaskPriority
    @Published var taskStatus: TaskStatus
    @Published var tillTime: String
    @Published var tillDate: String

    
    init(from task: Task) {
        taskName = task.name
        taskPriority = task.priority
        taskStatus = task.status
        tillTime = task.tillDate.timeIntervalSince1970.description
        tillDate = task.tillDate.description
    }
}
