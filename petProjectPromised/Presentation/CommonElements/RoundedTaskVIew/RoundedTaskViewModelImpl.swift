//
//  RoundedTaskViewModelImpl.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import Foundation

class RoundedTaskViewModelImpl: RoundedTaskViewModel {
    @Published var id: UUID
    @Published var taskName: String
    @Published var taskPriority: TaskPriority
    @Published var taskStatus: TaskStatus
    @Published var tillDate: String?
    @Published var tillTime: String?

    
    init(from task: Task) {
        id = task.id
        taskName = task.name
        taskPriority = task.priority
        taskStatus = task.status
        if let date = task.tillDate {
            tillDate = CustomFormatters.date.string(from: date)
        }
        
        if let time = task.tillTime {
            tillTime = CustomFormatters.dateTime.string(from: time)
        }
    }
}


extension RoundedTaskViewModelImpl {
    static var mock = RoundedTaskViewModelImpl(from: Task.sapmle)
}
