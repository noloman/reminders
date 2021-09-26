//
//  CreateReminderView.swift
//  Reminders
//
//  Created by Manu on 10/09/2021.
//

import SwiftUI
import CoreData

struct CreateReminderView: View {
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    @Environment(\.presentationMode) var presentationMode
    let reminderList: ReminderList
    
    @State var title: String = ""
    @State var notes: String = ""
    @State var dueDate: Date = Date()
    @State var priority: ReminderPriority = .none
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Notes", text: $notes)
                Picker("Priority", selection: $priority) {
                    ForEach(ReminderPriority.allCases, id:\.self) { (priority: ReminderPriority) in
                        Text(priority.fullDisplay).tag(priority)
                    }
                }
            }
            .toolbar {
                Button(action: {
                    Reminder.createWith(in: context, title, priority, notes, dueDate, isCompleted: false, in: reminderList) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Save")
                }
            }
        }
    }
}

struct CreateReminderView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        
        let reminderList = ReminderList(context: context)
        reminderList.title = "List title"
        return CreateReminderView(reminderList: reminderList)
    }
}
