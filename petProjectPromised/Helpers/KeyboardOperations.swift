//
//  KeyboardOperations.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 02.10.2025.
//

import UIKit
import SwiftUI
import Combine

struct KeyboardOperations {
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellable: AnyCancellable?

    init() {
        cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .compactMap { notification in
                guard let userInfo = notification.userInfo else { return nil }
                let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
                return notification.name == UIResponder.keyboardWillHideNotification ? 0 : endFrame.height
            }
            .map { (height: CGFloat) in
                print("keyboard height changed to: \(height)")
                return height
            }
            .assign(to: \.keyboardHeight, on: self)
    }
}
