//
//  RoundedTaskViewModelImpl.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import Foundation
import RealmSwift

class RoundedTaskViewModelImpl: RoundedTaskViewModel {
    @Published var id: ObjectId
    @Published var taskName: String
    @Published var taskPriority: TaskPriority
    @Published var taskStatus: TaskStatus
    @Published var tillDate: String?
    @Published var tillTime: String?
    @Published var isOverdue: Bool = false
    
    private let realmStorageService: RealmStorageServiceProtocol = RealmStorageService()
    
    init(from task: TaskDTO) {
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
        guard let originalDate = DateOperationService.convertToDate(from: task.tillDate, time: task.tillTime) else { return }
        isOverdue = originalDate < Date()
    }
    
    func removeTask() {
        do {
            try realmStorageService.removeTask(with: id)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}




extension RoundedTaskViewModelImpl {
    static var mock = RoundedTaskViewModelImpl(from: TaskDTO.sapmle)
}
