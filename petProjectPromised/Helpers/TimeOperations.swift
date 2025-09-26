//
//  TimeOperations.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 25.09.2025.
//

import Foundation

struct CustomFormatters {
    static let dateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a" // 08:30 PM
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
