//
//  DateOperationService.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 24.10.2025.
//

import Foundation

struct DateOperationService {
    static func convertToDate(from date: Date?, time: Date?) -> Date? {
        guard let date = date else { return nil }
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        guard let time = time else { return calendar.date(from: dateComponents) }
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var resultDateComponents = dateComponents
        resultDateComponents.hour = timeComponents.hour
        resultDateComponents.minute = timeComponents.minute
        
        return calendar.date(from: resultDateComponents)
    }
}
