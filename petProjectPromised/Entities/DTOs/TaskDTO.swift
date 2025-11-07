//
//  TaskDTO.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 05.11.2025.
//

import Foundation
import RealmSwift

class TaskDTO: Identifiable {
    var id: ObjectId
    var name: String
    var taskDescription: String
    var tillDate: Date?
    var tillTime: Date?
    var status: TaskStatus
    var priority: TaskPriority
    
    init(id: ObjectId = ObjectId.generate(), name: String = "", taskDescription: String = "", tillDate: Date? = nil, tillTime: Date? = nil, status: TaskStatus = .active, priority: TaskPriority = .medium) {
        self.id = id
        self.name = name
        self.taskDescription = taskDescription
        self.tillDate = tillDate
        self.tillTime = tillTime
        self.status = status
        self.priority = priority
    }
    
    init(fromObject task: Task) {
        id = task.id
        name = task.name
        taskDescription = task.taskDescription
        tillDate = task.tillDate
        tillTime = task.tillTime
        status = task.status
        priority = task.priority
    }
    
    func setStatus() {
        let originalDate = DateOperationService.convertToDate(from: tillDate, time: tillTime)
        if let originalDate = originalDate {
            status = originalDate < Date() ? .overdue : .active
        } else {
            status = .active
        }
    }
    
    func convertToObject() -> Task {
        .init(id: id, name: name, taskDescription: taskDescription, tillDate: tillDate, tillTime: tillTime, status: status, priority: priority)
    }
}

extension TaskDTO {
    static var sapmle = TaskDTO(name: "Sample task", taskDescription: "description", tillDate: Date(), tillTime: Date(), status: .active, priority: .medium)
    static var samplelist: [TaskDTO] = [TaskDTO(name: "Sample task", taskDescription: "description", tillDate: Date(), tillTime: Date(), status: .active, priority: .low),
                                     TaskDTO(name: "Sample task", taskDescription: "description", tillDate: Date(), tillTime: Date(), status: .active, priority: .medium),
                                     TaskDTO(name: "Sample task", taskDescription: "description", tillDate: Date(), tillTime: Date(), status: .active, priority: .high)]
}

