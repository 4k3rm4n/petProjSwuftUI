//
//  UserDefaultKey.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 26.09.2025.
//

import Foundation

enum UserDefaultKey: String {
    case tasks
}

extension UserDefault {

    convenience init(key: UserDefaultKey, defaultValue: Value, container: UserDefaults = .standard) {
        self.init(key: key.rawValue, defaultValue: defaultValue, container: container)
    }

}

extension UserDefault where Value: ExpressibleByNilLiteral {

    convenience init(key: UserDefaultKey, container: UserDefaults = .standard) {
        self.init(key: key.rawValue, defaultValue: nil, container: container)
    }

}
