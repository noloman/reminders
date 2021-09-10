//
//  Reminder+CoreDataProperties.swift
//  Reminders
//
//  Created by Manu on 10/09/2021.
//

import CoreData
import SwiftUI

extension Reminder {
    @NSManaged var title: String
    @NSManaged var priority: Int16
    @NSManaged var notes: String?
    @NSManaged var dueDate: Date?
    @NSManaged var isCompleted: Bool

    static func createWith(in context: NSManagedObjectContext, title: String, priority: ReminderPriority, notes: String, dueDate: Date, isCompleted: Bool) {
        let reminder = Reminder(context: context)
        reminder.dueDate = dueDate
        reminder.isCompleted = isCompleted
        reminder.notes = notes
        reminder.priority = priority.rawValue
        reminder.title = title
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static func basicFetchRequest() -> FetchRequest<Reminder> {
        FetchRequest(entity: Reminder.entity(), sortDescriptors: [])
    }
}
