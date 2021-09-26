//
//  ReminderList+CoreDataProperties.swift
//  Reminders
//
//  Created by Manu on 10/09/2021.
//
//

import CoreData

extension ReminderList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReminderList> {
        return NSFetchRequest<ReminderList>(entityName: "ReminderList")
    }

    @NSManaged public var title: String
    @NSManaged public var reminders: Array<Reminder>

    static func create(withTitle title: String, in context: NSManagedObjectContext) {
        let reminderList = ReminderList(context: context)
        reminderList.title = title
        do {
            try context.save()
        } catch  {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
