//
//  AddTaskViewModelImpl.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 29.09.2025.
//

import Foundation
import SwiftUICalendar
import Combine

class AddTaskViewModelImpl: AddTaskViewModel {
    @Published var taskNameText: String
    @Published var taskDescriptionText: String
    @Published var selectedPriority: TaskPriority
    @Published var taskTillTime: Date
    @Published var taskTillDate: YearMonthDay?
    @Published var isSelectedTime: Bool
    @Published var isSaveTaskButtonClicked: Bool
    
    let localStorageService: LocalStorageServiceProtocol = LocalStorageService()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        taskNameText = ""
        taskDescriptionText = ""
        selectedPriority = .medium
        taskTillTime = Date()
        isSelectedTime = false
        isSaveTaskButtonClicked = false
        
        $isSaveTaskButtonClicked
            .sink { [weak self] isClicked in
                guard let self = self else { return }
                if isClicked {
                    self.saveTask()
                    self.isSaveTaskButtonClicked = false
                }
            }
            .store(in: &cancellables)
    }
    
    deinit {
        print("Add Task view model deinited")
    }
    
    func isTaskNameTextFieldEmpty() -> Bool {
        taskNameText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private func saveTask() {
        do {
            try localStorageService.saveTask(with: .init(name: taskNameText, description: taskDescriptionText, tillDate: convertToDate(), tillTime: convertToTime(), status: .active, priority: selectedPriority))
        } catch let error {
            print(error.localizedDescription)
        }
        
        taskNameText = ""
        taskDescriptionText = ""
        selectedPriority = .medium
        taskTillTime = Date()
        taskTillDate = nil
        isSelectedTime = false
    }
    
    private func convertToDate() -> Date? {
        guard let taskTillDate = taskTillDate else { return nil }
        return taskTillDate.date
//        if isSelectedTime {
//            let calendar = Calendar.current
//            let dateComponents = calendar.dateComponents([.year, .month, .day], from: finalDate)
        //            let timeComponents = calendar.dateComponents([.hour, .minute], from: taskTillTime)
        //
        //            var combinedComponents = DateComponents()
        //            combinedComponents.year = dateComponents.year
        //            combinedComponents.month = dateComponents.month
        //            combinedComponents.day = dateComponents.day
        //            combinedComponents.hour = timeComponents.hour
        //            combinedComponents.minute = timeComponents.minute
        //
        //            return calendar.date(from: combinedComponents)
        //        }
    }
    
    private func convertToTime() -> Date? {
        if isSelectedTime {
            return taskTillTime
        } else {
            return nil
        }
    }
}
