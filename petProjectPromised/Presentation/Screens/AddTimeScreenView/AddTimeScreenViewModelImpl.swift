//
//  AddTimeScreenViewModelImpl.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 17.10.2025.
//

import Foundation
import SwiftUICalendar

class AddTimeScreenViewModelImpl: AddTimeScreenViewModel {
    
    @Published var isShowTimePicker: Bool
    @Published var taskSelectedTime: Date
    @Published var taskTillDate: YearMonthDay?
    private var newTask: TaskDTO
    
    private let realmStorageService: RealmStorageServiceProtocol = RealmStorageService()
    private let notificationService = NotificationService()
    
    init(from newTask: TaskDTO) {
        isShowTimePicker = false
        taskSelectedTime = Date()
        taskTillDate = nil
        self.newTask = newTask
    }
    
    func saveTask() {
        newTask.tillDate = convertToDate()
        newTask.tillTime = convertToTime()
        newTask.setStatus()
        do {
            try realmStorageService.saveOrUpdateTask(with: newTask.convertToObject())
            guard let dateComponents = convertToDateComponents() else { return }
            notificationService.createAndSheduleNotification(title: newTask.name, description: newTask.taskDescription, matchDate: dateComponents)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func convertToDateComponents() -> DateComponents? { // need to redone bad logic
        let calendar = Calendar.current
        var components = DateComponents()
        guard let date = newTask.tillDate else { return nil }
        components.year = calendar.component(.year, from: date)
        components.month = calendar.component(.month, from: date)
        components.day = calendar.component(.day, from: date)
        
        guard let dateTime = newTask.tillTime else { return components }
        components.hour = calendar.component(.hour, from: dateTime)
        components.minute = calendar.component(.minute, from: dateTime)
//        
//        if let date = calendar.date(from: components),
//           let newDate = calendar.date(byAdding: .hour, value: -1, to: date) {
//            components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: newDate)
//        }
        
        return components
    }
    
    private func convertToDate() -> Date? {
        guard let taskTillDate = taskTillDate else { return nil }
        return taskTillDate.date
    }
    
    private func convertToTime() -> Date? {
        if isShowTimePicker {
            return taskSelectedTime
        } else {
            return nil
        }
    }
    
    deinit {
        print("Add Time view model deinited")
    }
}
