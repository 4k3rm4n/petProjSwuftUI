//
//  KeyboardOperations.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 02.10.2025.
//

import UIKit

struct KeyboardOperations {
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
