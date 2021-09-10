//
//  Reminder+CoreDataProperties.swift
//  Reminders
//
//  Created by Manu on 10/09/2021.
//

import CoreData

extension Reminder {
    @NSManaged var title: String
    @NSManaged var priority: Int16
    @NSManaged var notes: String?
    @NSManaged var dueDate: Date?
    @NSManaged var isCompleted: Bool
}
