//
//  TaskStatus.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import Foundation
import RealmSwift

enum TaskStatus: String, PersistableEnum { // HomeScreenViewModelImpl
    case active
    case overdue
    case completed
}
