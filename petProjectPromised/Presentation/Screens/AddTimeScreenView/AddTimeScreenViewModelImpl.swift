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
    private var newTask: Task
    
    private let localStorageService: LocalStorageServiceProtocol = LocalStorageService()
    
    init(from newTask: Task) {
        isShowTimePicker = false
        taskSelectedTime = Date()
        taskTillDate = nil
        self.newTask = newTask
    }
    
    func saveTask() {
        newTask.tillDate = convertToDate()
        newTask.tillTime = convertToTime()
        do {
            try localStorageService.saveTask(with: newTask)
        } catch let error {
            print(error.localizedDescription)
        }
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
