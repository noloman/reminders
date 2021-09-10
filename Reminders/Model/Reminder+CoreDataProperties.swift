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
    
    static func createWith(in context: NSManagedObjectContext, _ title: String, _ priority: ReminderPriority, _ notes: String, _ dueDate: Date, isCompleted: Bool, _ onCompleted: @escaping () -> Void) {
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
        onCompleted()
    }
    
    static func basicFetchRequest() -> FetchRequest<Reminder> {
        FetchRequest(entity: Reminder.entity(), sortDescriptors: [])
    }
    
    static func completedRemindersFetchRequest() -> FetchRequest<Reminder> {
        let isCompletePredicate = NSPredicate(format: "%K == %@", "isCompleted", NSNumber(value: false))
        return FetchRequest(entity: Reminder.entity(), sortDescriptors: [], predicate: isCompletePredicate)
    }
}
