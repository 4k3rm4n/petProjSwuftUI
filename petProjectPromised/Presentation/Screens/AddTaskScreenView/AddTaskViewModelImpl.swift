//
//  AddTaskViewModelImpl.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 29.09.2025.
//

import Foundation

class AddTaskViewModelImpl: AddTaskViewModel {
    @Published var taskNameText: String
    @Published var taskDescriptionText: String
    @Published var selectedPriority: TaskPriority
    
    init() {
        taskNameText = ""
        taskDescriptionText = ""
        selectedPriority = .medium
    }
}
