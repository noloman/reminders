//
//  RemindersView.swift
//  Reminders
//
//  Created by Manu on 12/09/2021.
//

import SwiftUI

struct RemindersView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var newReminderSheetShown: Bool = false
    
    var fetchRequest: FetchRequest<Reminder>
    var reminders: FetchedResults<Reminder> { return fetchRequest.wrappedValue }
    let remindersList: ReminderList
    
    init(list: ReminderList) {
        self.remindersList = list
        self.fetchRequest = Reminder.reminders(in: self.remindersList)
    }
    
    var body: some View {
        List {
            if (reminders.isEmpty) {
                Text("There are no reminders")
            } else {
                ForEach(reminders, id: \.self) { reminder in
                    ReminderRowView(reminder: reminder)
                }
                .onDelete(perform: deleteItems)
            }
        }
        .toolbar {
            Button(action: {
                self.newReminderSheetShown.toggle()
            }) {
                Label("Add Item", systemImage: "plus")
            }.sheet(isPresented: $newReminderSheetShown) {
                CreateReminderView(reminderList: remindersList)
            }
        }
        .navigationTitle("Reminders")
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { self.reminders[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let newReminderList = ReminderList(context: context)
        newReminderList.title = "New reminder list"
        return RemindersView(list: newReminderList)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
