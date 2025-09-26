//
//  LocalStorageService.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 26.09.2025.
//

import Foundation

protocol LocalStorageServiceProtocol {
    func saveTask(with task: Task) throws
    func removeTask(with id: UUID) throws
    func getTask(by id: UUID) -> Task?
}

struct LocalStorageService: LocalStorageServiceProtocol {
    
    private let userDefaultsStorage = UserDefaultStorage.shared
    
    func saveTask(with task: Task) throws {
        var tasks = userDefaultsStorage.tasks
        tasks.insert(task, at: .zero)
        
        userDefaultsStorage.tasks = tasks
    }
    
    func removeTask(with id: UUID) throws {
        var tasks = userDefaultsStorage.tasks
        tasks.removeAll { $0.id == id }
        
        userDefaultsStorage.tasks = tasks
    }
    
    func getTask(by id: UUID) -> Task? {
        userDefaultsStorage.tasks.first(where: {$0.id == id})
    }
}
