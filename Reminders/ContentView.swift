//
//  ContentView.swift
//  Reminders
//
//  Created by Manu on 10/09/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var newReminderSheetShown: Bool = false
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.dueDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Reminder>
    
    var body: some View {
        NavigationView {
            List {
                if (items.isEmpty) {
                    Text("There are no reminders")
                } else {
                    ForEach(items, id: \.self) { reminder in
                        Text(reminder.title)
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
                    CreateReminderView(isSheetShown: $newReminderSheetShown)
                }
            }
            .navigationTitle("Reminders")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
