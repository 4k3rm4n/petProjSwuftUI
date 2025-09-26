//
//  UserDefaultStorage.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 26.09.2025.
//

import Foundation

class UserDefaultStorage {
    static let shared = UserDefaultStorage()
    
    private init() {}
    
    @UserDefault(key: .tasks, defaultValue: [])
    var tasks: [Task]
}
