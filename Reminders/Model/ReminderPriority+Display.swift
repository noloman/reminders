//
//  ReminderPriority+Display.swift
//  Reminders
//
//  Created by Manu on 10/09/2021.
//

import Foundation

enum ReminderPriority: Int16, CaseIterable {
    case none = 0
    case low = 1
    case medium = 2
    case high = 3
}

extension ReminderPriority {
    var fullDisplay: String {
        switch self {
        case .none:
            return "None"
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
}
