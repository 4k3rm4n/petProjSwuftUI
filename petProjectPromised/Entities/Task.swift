//
//  Task.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import Foundation
import RealmSwift

//struct Task: Identifiable, Hashable, Codable {
//    var id: UUID
//    var name: String
//    var description: String
//    var tillDate: Date?
//    var tillTime: Date?
//    var status: TaskStatus
//    var priority: TaskPriority
//    
//    init(id: UUID = UUID(), name: String = "", description: String = "", tillDate: Date? = nil, tillTime: Date? = nil, status: TaskStatus = .active, priority: TaskPriority = .medium) {
//        self.id = id
//        self.name = name
//        self.description = description
//        self.tillDate = tillDate
//        self.tillTime = tillTime
//        self.status = status
//        self.priority = priority
//    }
//    
//    mutating func setStatus() {
//        let originalDate = DateOperationService.convertToDate(from: tillDate, time: tillTime)
//        if let originalDate = originalDate {
//            status = originalDate < Date() ? .overdue : .active
//        } else {
//            status = .active
//        }
//    }
//}
//
//extension Task {
//    static var sapmle = Task(name: "Sample task", description: "description", tillDate: Date(), tillTime: Date(), status: .active, priority: .medium)
//    static var samplelist: [Task] = [Task(name: "Sample task", description: "description", tillDate: Date(), tillTime: Date(), status: .active, priority: .low),
//                                     Task(name: "Sample task", description: "description", tillDate: Date(), tillTime: Date(), status: .active, priority: .medium),
//                                     Task(name: "Sample task", description: "description", tillDate: Date(), tillTime: Date(), status: .active, priority: .high)]
//}


class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var taskDescription: String
    @Persisted var tillDate: Date?
    @Persisted var tillTime: Date?
    @Persisted var status: TaskStatus
    @Persisted var priority: TaskPriority
    
    convenience init(id: ObjectId = ObjectId.generate(), name: String = "", taskDescription: String = "", tillDate: Date? = nil, tillTime: Date? = nil, status: TaskStatus = .active, priority: TaskPriority = .medium) {
        self.init()
        self.id = id
        self.name = name
        self.taskDescription = taskDescription
        self.tillDate = tillDate
        self.tillTime = tillTime
        self.status = status
        self.priority = priority
    }
    
//    init(id: ObjectId = ObjectId.generate(), name: String = "", taskDescription: String = "", tillDate: Date? = nil, tillTime: Date? = nil, status: TaskStatus = .active, priority: TaskPriority = .medium) {
//        super.init()
//        self.id = id
//        self.name = name
//        self.taskDescription = taskDescription
//        self.tillDate = tillDate
//        self.tillTime = tillTime
//        self.status = status
//        self.priority = priority
//    }
}
