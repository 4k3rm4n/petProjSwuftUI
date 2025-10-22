//
//  NotificationService.swift
//  petProjectPromised
//
//  Created by Bohdan Peretiatko on 22.10.2025.
//

import Foundation
import NotificationCenter

struct NotificationService {
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { succes, error in
            if succes {
                print("got")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func createAndSheduleNotification(title: String, description: String, matchDate: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = "Ouch, less that our left to do this task"
        content.body = description
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: matchDate, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
