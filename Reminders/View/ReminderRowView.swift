//
//  ReminderRowView.swift
//  Reminders
//
//  Created by Manu on 10/09/2021.
//

import SwiftUI

struct ReminderRowView: View {
    let reminder: Reminder
    @State var isCompleted = false
    var priority: String {
        ReminderPriority(rawValue: reminder.priority)?.fullDisplay ?? "Unknown"
    }
    
    var body: some View {
        HStack {
            Button(action: {
                self.isCompleted.toggle()
            }, label: {
                Circle()
                    .padding(4)
                    .overlay(
                        Circle()
                            .stroke(Color.red, lineWidth: 2)
                    )
                    .foregroundColor(isCompleted ? .red : .clear)
                    .frame(width:20, height: 20)
            })
            Text("\(priority) - \(reminder.title)")
        }
    }
}

struct ReminderRowView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        
        let newReminder = Reminder(context: context)
        newReminder.title = "New reminder"
        newReminder.priority = ReminderPriority(rawValue: ReminderPriority.high.rawValue)!.rawValue
        
        return ReminderRowView(reminder: newReminder)
    }
}
