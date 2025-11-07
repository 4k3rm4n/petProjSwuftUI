//
//  RealmStorageService.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 04.11.2025.
//

import Foundation
import RealmSwift
import Combine

protocol RealmStorageServiceProtocol {
    func saveOrUpdateTask(with task: Task) throws
    func removeTask(with id: ObjectId) throws
    func getTask(by id: ObjectId) -> Task?
    
    func subscribeToTasks() -> AnyPublisher<[Task], Never>
}

final class RealmStorageService: RealmStorageServiceProtocol {
    private let storage: Realm?
    
    init() {
        self.storage = try? Realm()
    }
    
    func saveOrUpdateTask(with task: Task) throws {
        guard let storage = storage else {
            fatalError("Realm storage is unavailable")
        }
        try storage.write {
            storage.add(task, update: .all)
        }
    }
    
    func removeTask(with id: RealmSwift.ObjectId) throws {
        guard let storage = storage else {
            fatalError("Realm storage is unavailable")
        }
        if let task = storage.object(ofType: Task.self, forPrimaryKey: id) {
            try storage.write {
                storage.delete(task)
            }
        } else {
            fatalError("Task with id \(id) not found")
        }
    }
    
    func getTask(by id: RealmSwift.ObjectId) -> Task? {
        guard let storage = storage else {
            fatalError("Realm storage is unavailable")
        }
        return storage.object(ofType: Task.self, forPrimaryKey: id)
    }
    
    func subscribeToTasks() -> AnyPublisher<[Task], Never> {
        try! Realm().objects(Task.self)
            .collectionPublisher
            .freeze()
            .map { Array($0) }
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
