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
    @Published var isOverdue: Bool = false
    
    private let localStorageService =  LocalStorageService()
    private let dateOperationService = DateOperationService()
    
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
        guard let originalDate = dateOperationService.convertToDate(from: task.tillDate, time: task.tillTime) else { return }
        isOverdue = originalDate < Date()
    }
    
    func removeTask() {
        do {
            try localStorageService.removeTask(with: id)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}




extension RoundedTaskViewModelImpl {
    static var mock = RoundedTaskViewModelImpl(from: Task.sapmle)
}
